#!/usr/bin/zsh
ln -s ~/Documents/Projects/dotfiles/.mackup ~/.mackup
ln -s ~/Documents/Projects/dotfiles/.mackup.cfg ~/.mackup.cfg
/usr/local/py-utils/bin/mackup restore -f
