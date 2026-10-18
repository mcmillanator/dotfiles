#!/usr/bin/env bash
#
# devtools — install a distro-agnostic "toolbelt" of self-contained CLI binaries
# into $DEVTOOLS_DIR (default: ~/.local/share/devtools).
#
# The directory is meant to be bind-mounted read-only into any devcontainer at
# /opt/devtools, with /opt/devtools/bin on PATH. Most binaries are static
# (Go/musl) and neovim ships a relocatable tree, so the SAME toolbelt runs on
# Ubuntu, Debian, Fedora, etc. — no per-project install, no base-image swap.
#
# Usage:
#   install.sh [--force] [--dir DIR]
#
#   --force      reinstall even if the stamped versions already match
#   --dir DIR    install dir (default $DEVTOOLS_DIR or ~/.local/share/devtools)
#
set -euo pipefail

# ---- pinned versions -------------------------------------------------------
NVIM=0.11.3
OPENCODE=1.19.3
NODE=24.22.0 # official LTS tarball; one version everywhere. nvm (shared home) still wins in shells that load it.
LAZYGIT=0.66.2
MCFLY=0.9.4
FZF=0.74.5
FD=10.5.0
RIPGREP=15.2.0
ZOXIDE=0.10.0
DIRENV=2.38.2
DELTA=0.20.1
TERRAFORM=1.16.6
TERRAFORM_LS=0.39.0
TFLINT=0.64.0
TERRAGRUNT=1.1.6
AWSCLI=2 # the v2 installer bundle URL is unversioned; tracks the latest v2

DEVTOOLS_DIR="${DEVTOOLS_DIR:-$HOME/.local/share/devtools}"
FORCE=0
while [ $# -gt 0 ]; do
  case "$1" in
    --force) FORCE=1 ;;
    --dir) DEVTOOLS_DIR="$2"; shift ;;
    -h|--help) sed -n '2,17p' "$0"; exit 0 ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
  shift
done

BIN="$DEVTOOLS_DIR/bin"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$BIN"

# ---- architecture -> upstream asset names ----------------------------------
machine="$(uname -m)"
case "$machine" in
  x86_64 | amd64)
    NVIM_A=x86_64; OC_A=x64; NODE_A=x64; LG_A=x86_64; FZF_A=amd64; DIR_A=amd64
    GO_A=amd64; AWSCLI_A=x86_64
    TRIPLE=x86_64-unknown-linux
    ;;
  aarch64 | arm64)
    NVIM_A=arm64; OC_A=arm64; NODE_A=arm64; LG_A=arm64; FZF_A=arm64; DIR_A=arm64
    GO_A=arm64; AWSCLI_A=aarch64
    TRIPLE=aarch64-unknown-linux
    ;;
  *)
    echo "unsupported architecture: $machine" >&2
    exit 1
    ;;
esac

stamp="$DEVTOOLS_DIR/.versions"
want="nvim=$NVIM opencode=$OPENCODE node=$NODE lazygit=$LAZYGIT mcfly=$MCFLY fzf=$FZF fd=$FD rg=$RIPGREP zoxide=$ZOXIDE direnv=$DIRENV delta=$DELTA terraform=$TERRAFORM terraform-ls=$TERRAFORM_LS tflint=$TFLINT terragrunt=$TERRAGRUNT aws=$AWSCLI arch=$machine"
if [ "$FORCE" = 0 ] && [ -f "$stamp" ] && [ "$(cat "$stamp")" = "$want" ]; then
  echo "devtools already up to date at $DEVTOOLS_DIR"
  exit 0
fi

log() { printf '  %s\n' "$*"; }

# Replace DEST with SRC safely, even if DEST is a currently-running binary.
# cp/install write in place and fail with ETXTBSY on an executing file; copying
# to a temp in DEST's own directory then renaming swaps the inode instead, so the
# running process keeps the old one and the upgrade still lands. The temp is in
# DEST's dir to guarantee the rename stays on one filesystem.
install_bin() { # <src> <dest>
  local src="$1" dest="$2" tmp="$2.tmp.$$"
  cp -f "$src" "$tmp"
  chmod 0755 "$tmp"
  mv -f "$tmp" "$dest"
}

# fetch a release asset and install the (single) binary named $1
fetch_single() { # <binname> <url>
  local name="$1" url="$2" d f
  d="$TMP/$name"
  mkdir -p "$d"
  curl -fsSL "$url" -o "$TMP/$name.dl"
  case "$url" in
    *.tar.gz | *.tgz) tar -xzf "$TMP/$name.dl" -C "$d" --no-same-owner ;;
    *.zip) unzip -q "$TMP/$name.dl" -d "$d" ;;
    *) install_bin "$TMP/$name.dl" "$BIN/$name"; return ;;
  esac
  f="$(find "$d" -type f -name "$name" -perm -u+x | head -1 || true)"
  [ -n "$f" ] || f="$(find "$d" -type f -name "$name" | head -1 || true)"
  [ -n "$f" ] || { echo "!! '$name' not found in $url" >&2; return 1; }
  install_bin "$f" "$BIN/$name"
}

echo "Installing devtools into $DEVTOOLS_DIR ($machine)"

# neovim ships a relocatable tree (bin/ + lib/ + share/); strip the top dir so
# nvim finds its runtime at ../share/nvim/runtime relative to bin/nvim.
# Extract to temp then copy with --remove-destination: each existing file is
# unlinked before being created (so a *running* nvim doesn't cause ETXTBSY),
# while directories merge instead of being unlinked.
log "neovim $NVIM"
curl -fsSL "https://github.com/neovim/neovim/releases/download/v$NVIM/nvim-linux-$NVIM_A.tar.gz" -o "$TMP/nvim.tgz"
mkdir -p "$TMP/nvim"
tar -xzf "$TMP/nvim.tgz" -C "$TMP/nvim" --strip-components=1 --no-same-owner
cp -a --remove-destination "$TMP/nvim/." "$DEVTOOLS_DIR/"

# node's official tarball is a relocatable tree (bin/ + lib/node_modules/ ...);
# npm/npx/corepack ship as *relative* symlinks under bin/, so they survive the
# /opt/devtools mount. Extract to temp + --remove-destination (ETXTBSY-safe).
log "node $NODE"
curl -fsSL "https://nodejs.org/dist/v$NODE/node-v$NODE-linux-$NODE_A.tar.gz" -o "$TMP/node.tgz"
mkdir -p "$TMP/node"
tar -xzf "$TMP/node.tgz" -C "$TMP/node" --strip-components=1 --no-same-owner
cp -a --remove-destination "$TMP/node/." "$DEVTOOLS_DIR/"

log "opencode $OPENCODE"
fetch_single opencode "https://github.com/sst/opencode/releases/download/v$OPENCODE/opencode-linux-$OC_A.tar.gz"

log "lazygit $LAZYGIT"
fetch_single lazygit "https://github.com/jesseduffield/lazygit/releases/download/v$LAZYGIT/lazygit_${LAZYGIT}_linux_${LG_A}.tar.gz"

log "mcfly $MCFLY"
fetch_single mcfly "https://github.com/cantino/mcfly/releases/download/v$MCFLY/mcfly-v$MCFLY-$TRIPLE-musl.tar.gz"

log "fzf $FZF"
fetch_single fzf "https://github.com/junegunn/fzf/releases/download/v$FZF/fzf-$FZF-linux_$FZF_A.tar.gz"

log "fd $FD"
fetch_single fd "https://github.com/sharkdp/fd/releases/download/v$FD/fd-v$FD-$TRIPLE-musl.tar.gz"

log "ripgrep $RIPGREP"
fetch_single rg "https://github.com/BurntSushi/ripgrep/releases/download/$RIPGREP/ripgrep-$RIPGREP-$TRIPLE-musl.tar.gz"

log "zoxide $ZOXIDE"
fetch_single zoxide "https://github.com/ajeetdsouza/zoxide/releases/download/v$ZOXIDE/zoxide-$ZOXIDE-$TRIPLE-musl.tar.gz"

log "direnv $DIRENV"
fetch_single direnv "https://github.com/direnv/direnv/releases/download/v$DIRENV/direnv.linux-$DIR_A"

log "delta $DELTA"
fetch_single delta "https://github.com/dandavison/delta/releases/download/$DELTA/delta-$DELTA-$TRIPLE-musl.tar.gz"

log "terraform $TERRAFORM"
fetch_single terraform "https://releases.hashicorp.com/terraform/$TERRAFORM/terraform_${TERRAFORM}_linux_${GO_A}.zip"

log "terraform-ls $TERRAFORM_LS"
fetch_single terraform-ls "https://releases.hashicorp.com/terraform-ls/$TERRAFORM_LS/terraform-ls_${TERRAFORM_LS}_linux_${GO_A}.zip"

log "tflint $TFLINT"
fetch_single tflint "https://github.com/terraform-linters/tflint/releases/download/v$TFLINT/tflint_linux_${GO_A}.zip"

log "terragrunt $TERRAGRUNT"
fetch_single terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/v$TERRAGRUNT/terragrunt_linux_${GO_A}"

# aws-cli v2 is an installer bundle (tree under aws-cli/), not a single binary.
log "aws-cli $AWSCLI"
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_A}.zip" -o "$TMP/awscli.zip"
mkdir -p "$TMP/awscli"
unzip -q "$TMP/awscli.zip" -d "$TMP/awscli"
( cd "$TMP/awscli" && ./aws/install --install-dir "$DEVTOOLS_DIR/aws-cli" --bin-dir "$BIN" --update ) >/dev/null
# the installer writes ABSOLUTE symlinks under $DEVTOOLS_DIR (bin/aws,
# bin/aws_completer and aws-cli/v2/current), which dangle once the toolbelt is
# mounted at /opt/devtools; rewrite all three relatively.
rm -f "$BIN/aws" "$BIN/aws_completer"
ln -s "../aws-cli/v2/current/bin/aws" "$BIN/aws"
ln -s "../aws-cli/v2/current/bin/aws_completer" "$BIN/aws_completer"
aws_v="$(basename "$(readlink -f "$DEVTOOLS_DIR/aws-cli/v2/current")")"
ln -sfn "$aws_v" "$DEVTOOLS_DIR/aws-cli/v2/current"

printf '%s' "$want" > "$stamp"
echo "Done. $BIN contains the toolbelt; bind-mount $DEVTOOLS_DIR at /opt/devtools in devcontainers."
