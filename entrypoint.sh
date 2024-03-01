#!/bin/bash
ln -s ~/.mackup ~/Documents/Projects/dotfiles/.mackup
ln -s ~/.mackup.cfg ~/Documents/Projects/dotfiles/.mackup.cfg
mackup restore -f
