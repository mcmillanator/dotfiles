#!/usr/bin/bash
echo "Running entrypoint as user: ${USER}"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
dotfiles_repo="https://github.com/mcmillanator/dotfiles.git"
git clone --depth 1 "${dotfiles_repo}" "${HOME}/.dotfiles"
mackup_dir=$SCRIPT_DIR/.mackup
mackup_conf=$SCRIPT_DIR/.mackup.cfg
if [ ! -d ~/.mackup ]; then
  echo "folder not found linking"
	ln -fs $mackup_dir ~/.mackup
fi

if [ ! -f ~/.mackup.cfg ]; then
  echo "file not found linking"
	ln -fs $mackup_conf ~/.mackup.cfg
fi
export PATH=$PATH:/usr/local/py-utils/bin/
mackup link -f
