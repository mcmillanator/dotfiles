#!/bin/bash
git submodule init
git submodule update

DOTFILES=`pwd`
$DOTFILES/i3.symlink/scripts/i3status.sh
echo "export DOTFILES=$DOTFILES" > ~/.dotfiles_config
files=($(find . -name '*.symlink' -print))
files+=(vim .tmux/.tmux.conf)

function link () {
	ln -sfn $DOTFILES/$1 ~/.$2
	echo "symlinked $1 to ~/.$2"
}

function parse-filename () {
	local file=$(basename $1)
	local file="${file#.}"
	local file="${file%.symlink}"
	echo $file
}


for i in "${files[@]}"
do
  :
	file=$(parse-filename $i)
	link $i $file
done

ln -sfn $DOTFILES/config/ranger ~/.config

source ~/.bashrc
i3-msg reload
