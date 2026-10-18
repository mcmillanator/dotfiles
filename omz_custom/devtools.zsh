# Portable toolbelt — static CLI tools installed once on the host and shared
# with every container. Sourced by oh-my-zsh (it globs $ZSH_CUSTOM/*.zsh), so this
# runs on the host and inside every distrobox (which shares $HOME).
#
# devcontainers mount the same dir at /opt/devtools and add it via remoteEnv;
# distrobox just needs it on PATH, which is what this does.
# Populate with: ~/.devcontainers/devtools/install.sh
if [ -d "$HOME/.local/share/devtools/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/share/devtools/bin:"*) ;;
    *) export PATH="$HOME/.local/share/devtools/bin:$PATH" ;;
  esac
fi
