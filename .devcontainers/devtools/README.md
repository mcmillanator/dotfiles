# devtools — portable toolbelt

A distro-agnostic bundle of the CLI tools I want in **every** devcontainer
(neovim + opencode + the usual suspects), installed **once on the host** and
bind-mounted into any container. No per-project install, no base-image swap, no
"Ubuntu everywhere" constraint.

## Why

Baking these into a base image fuses them to one distro (you end up maintaining
one base image per distro). Installing them per project is slow. Instead, the
toolbelt lives in one host directory and attaches to any container:

- binaries are static (Go/musl) or self-contained (neovim's relocatable tree),
  so the same files run on Ubuntu, Debian, Fedora, …;
- the container just gets a read-only mount + a `PATH` entry — nothing is built.

## Install (once, on the host)

```sh
~/.devcontainers/devtools/install.sh          # -> ~/.local/share/devtools
~/.devcontainers/devtools/install.sh --force  # reinstall / bump versions
```

Bump versions by editing the `NVIM=… OPENCODE=… …` block at the top of
`install.sh`, then re-run with `--force`. The script stamps the installed set in
`$DEVTOOLS_DIR/.versions` and is a no-op when it already matches.

## Attach to any project

Add both blocks to the project's `.devcontainer/devcontainer.json`
(see `attach.jsonc` for a copy-paste snippet). This works with **any** base
image — you do not override or replace the project's base.

```jsonc
"mounts": [
  {
    "source": "${localEnv:HOME}/.local/share/devtools",
    "target": "/opt/devtools",
    "type": "bind",
    "readOnly": true
  }
],
"remoteEnv": {
  "PATH": "/opt/devtools/bin:${containerEnv:PATH}"
}
```

The toolbelt's config (neovim, opencode) still comes from your dotfiles bind, so
add that too if the project doesn't already have it.

## What's in it

| tool | notes |
| --- | --- |
| neovim | relocatable tree (`bin/`, `lib/`, `share/`) |
| opencode | |
| node, npm, npx | official LTS tarball, relocatable; powers nvim plugins/LSP hosts |
| lazygit, delta | git |
| fzf, fd, ripgrep, zoxide | search/nav |
| mcfly | shell history |
| direnv | per-dir env |
| terraform, tflint, terragrunt | terraform toolchain |
| terraform-ls | language server for nvim's LSP (replaces the dropped tf layer) |
| aws | aws-cli v2 (installer bundle under `aws-cli/`, relative symlinks) |

## Distrobox

Distrobox already **shares your host `$HOME`**, so nothing needs mounting — the
toolbelt and your dotfiles are present in every container at the same paths. You
only need `~/.local/share/devtools/bin` on `PATH`, which
`.omz_custom/devtools.zsh` does for the host and every distrobox (it lives in the
shared `$HOME`).

```sh
distrobox create --image fedora:latest --name dev-fedora
distrobox enter dev-fedora    # nvim, opencode, terraform, rg, … just work
```

For reproducible containers, use the manifest next to this file:

```sh
distrobox assemble create --file ~/.devcontainers/devtools/distrobox.ini
```

The manifest only installs the OS-level bits each distro lacks (`zsh`, `git`,
`tmux`) — everything else comes from the shared toolbelt.

## Caveats

- **glibc vs musl:** the musl/Go builds work on glibc distros. neovim and a
  couple of others are glibc-linked, so on musl bases (Alpine) use the matching
  musl assets — add a case in the script if you need Alpine.
- **Not everything is portable:** `zsh`, `tmux`, `git` are distro packages —
  get those from the base image or a devcontainer feature. Node is the
  exception: it ships a relocatable tarball, so it lives here as **one pinned
  LTS**. Per-project node versions stay an nvm job (your shared-home `nvm`
  wins in any shell that loads it), and this toolbelt is the user-space CLI
  layer that's annoying to reinstall.
- **`npm install -g` can't write to the toolbelt** (it's mounted read-only in
  containers, and on the host would pollute the dir): install LSP servers via
  **mason.nvim** instead — they land in `~/.local/share/nvim/mason`, which the
  shared home/devcontainer-home bind persists — and they run on this node.
- **arch:** `x86_64` and `aarch64` are handled; add cases for others.
