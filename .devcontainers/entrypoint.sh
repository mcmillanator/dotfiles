#!/usr/bin/zsh
mackup_dir=~/Documents/Projects/dotfiles/.mackup
mackup_conf=~/Documents/Projects/dotfiles/.mackup.cfg
if [ ! -d ~/.mackup ]; then
  echo "folder not found linking"
	ln -fs $mackup_dir ~/.mackup
fi

if [ ! -f ~/.mackup.cfg ]; then
  echo "file not found linking"
	ln -fs $mackup_conf ~/.mackup.cfg
fi
/usr/local/py-utils/bin/mackup restore -f
