#!/usr/bin/bash
echo "Running entrypoint as user: ${USER}"
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Repos are browsable without hidden dirs, but $HOME wants hidden paths -- and
# mackup cannot map "home != storage" names. So folders get linked here, while
# plain files (.zshrc, .gitconfig, .inputrc, ...) stay on mackup link below.
# Existing real dirs/files are never clobbered; symlinks are repointed.
link_dir() { # <repo-relative source> <home-relative destination>
	local src="$SCRIPT_DIR/$1" dst="$HOME/$2"
	if [ -e "$dst" ] && [ ! -L "$dst" ]; then
		echo "skip real dir/file: $dst"
		return
	fi
	mkdir -p "$(dirname "$dst")"
	ln -sfn "$src" "$dst"
	echo "linked $dst -> $src"
}
link_dir mackup .mackup
link_dir config/alacritty .config/alacritty
link_dir config/nvim .config/nvim
link_dir devcontainers .devcontainers
link_dir omz_custom .omz_custom
link_dir tmux/scripts .tmux/scripts

# ssh is a plain file inside a real (mode 0700) ~/.ssh
if [ -e "$HOME/.ssh/authorized_keys" ] && [ ! -L "$HOME/.ssh/authorized_keys" ]; then
	echo "skip real file: ~/.ssh/authorized_keys"
else
	mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
	ln -sfn "$SCRIPT_DIR/ssh/authorized_keys" "$HOME/.ssh/authorized_keys"
	echo "linked $HOME/.ssh/authorized_keys"
fi

if [ ! -f ~/.mackup.cfg ]; then
	echo "file not found linking"
	ln -fs "$SCRIPT_DIR/.mackup.cfg" "${HOME}/.mackup.cfg"
fi
export PATH=$PATH:/usr/local/py-utils/bin/
mackup link -f --config-file "${HOME}/.mackup.cfg"
