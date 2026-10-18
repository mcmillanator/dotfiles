# Dotfiles

Personal environment built around **Neovim + OpenCode**, designed so the host,
distrobox containers, and devcontainers all share one tool layer — nothing is
rebuilt per project.

Repo folders are deliberately **unhidden** (`config/`, `omz_custom/`, …) while
installing to the conventional **hidden** paths in `$HOME`. Plain dotfiles are
synced by mackup as always; mackup can't remap names, so folder links are done
by `install.sh`.

## Layout

| repo | $HOME | what |
| --- | --- | --- |
| `install.sh` | — | bootstrap: links folders + mackup config, runs `mackup link -f` |
| `config/` | `~/.config` | app configs; `config/nvim` is the Neovim setup |
| `omz_custom/` | `~/.omz_custom` | zsh extras: `aliases.zsh` (devcontainer helpers), `devtools.zsh` (toolbelt PATH), themes |
| `devcontainers/` | `~/.devcontainers` | devcontainer configs, `prebuilt/` base image, `devtools/` toolbelt, compose `overrides/` |
| `mackup/` | `~/.mackup` | custom mackup app definitions |
| `ssh/`, `tmux/` | `~/.ssh` (files), `~/.tmux/scripts` | auth keys; tmux scripts |
| `.zshrc`, `.gitconfig`, `.tmux.conf*`, `.alacritty.toml`, … | `~/` | mackup-synced plain dotfiles |

## First-time setup

```sh
git clone <repo> ~/dotfiles && cd ~/dotfiles
./install.sh                            # link everything into $HOME
~/.devcontainers/devtools/install.sh    # portable CLI toolbelt (see below)
```

## devtools — the portable toolbelt

`devcontainers/devtools/install.sh` pins and installs static / self-contained
release binaries into `~/.local/share/devtools`: **neovim, opencode, node**
(+ npm/npx), **tree-sitter CLI**, lazygit, mcfly, fzf, fd, ripgrep, zoxide,
delta, direnv, the **terraform stack** (terraform, terraform-ls, tflint,
terragrunt), and **aws-cli**.

- **Host & distrobox:** `omz_custom/devtools.zsh` puts it on `PATH`
  (distrobox shares `$HOME`). Declarative boxes: `devtools/distrobox.ini`.
- **Devcontainers:** bind-mounted read-only at `/opt/devtools` and prepended to
  `PATH` via `remoteEnv` — snippet in `devtools/attach.jsonc`, already wired
  into the configs here.
- Re-runs are incremental: only tools whose pin changed (or files that went
  missing) are refetched. Upgrading a tool = bump the pin, rerun.

Details: `devcontainers/devtools/README.md`.

## devcontainers (podman)

One base image; language layers are features, not images:

- **`mcmillanator/prebuilt-base`** (`devcontainers/prebuilt/`) = OS + shell
  basics (zsh/oh-my-zsh, tmux, git, node, mackup). Rebuild with `dcprebuild`.
- **Language toolchains are devcontainer features** declared in each project
  config (e.g. `python.jsonc` carries the python feature).
- The `devcontainer()` alias in `omz_custom/aliases.zsh` forces podman
  (`--docker-path podman`); images tag/push via `dcprebuildpush`.
- **Shared persistent home:** every config bind-mounts `~/.devcontainer-home`
  as the container `$HOME` — shell history, nvm/uv/mason state, and editor
  data carry across projects and containers.

Helpers: `dcup <name>`, `dczsh <name>`, `dcnvim <name>`, `dcbash <name>`,
`dc <name> <cmd>` against `~/.devcontainers/<name>.jsonc`; plus `dcdown`,
`dcbuild`, `dcsetup`, `dctakeover`.

## Neovim

kickstart-based (`config/nvim/`), lazy.nvim, one spec per plugin in
`lua/plugins/*.lua`. Leader is `<space>`.

- **OpenCode:** `sudo-tee/opencode.nvim` connects to a running
  `opencode serve` (default `http://127.0.0.1` port `8082`, basic auth —
  override with `OPENCODE_SERVER_URL` / `OPENCODE_SERVER_PORT` /
  `OPENCODE_PASSWORD`; per upstream docs the port goes in `port`, never in
  the URL). Verify with `:checkhealth opencode`; `<leader>oi` opens the
  prompt.
- **Treesitter:** the rewritten `main` branch; parsers install via the new
  API; folds start open (`foldlevel=99`).
- **Formatting:** stylua for Lua; conform on save (see conventions for the
  exclusions).

## Conventions

- Commit prefixes `fix:` / `feat:` / `chore:` / `refactor:` / `style:` /
  `nit:` — git aliases in `.gitconfig`.
- **Spaces by default in every filetype** (vim ships `expandtab` off): the
  policy lives in `config/nvim/init.lua` (`tab_filetypes` allowlists the
  exceptions — `make`, `go` — that genuinely need hard tabs; per-buffer opt-in
  is `:setlocal noexpandtab`). `.editorconfig` mirrors it for other tools, and
  vim-sleuth auto-detection is off (`g:sleuth_automatic = 0`) so it can't flip
  buffers back. json/jsonc are additionally excluded from conform's save-time
  LSP fallback (it used to re-serialize buffers with tabs).
- Lua style is `.stylua.toml` (2-space, single quotes, no call parens).
