#!/bin/bash
ln -s ~/Documents/Projects/dotfiles/.mackup ~/.mackup
ln -s ~/Documents/Projects/dotfiles/.mackup.cfg ~/.mackup.cfg
mackup restore -f
