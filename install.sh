#!/bin/bash
DOTFILES=`pwd`
echo "export DOTFILES=$DOTFILES" > ~/.dotfiles_config

function link () {
	ln -sf $DOTFILES/$1 ~/.$2
}

files=($(find . -d 2 -type f -name '*.symlink' -print))

for i in "${files[@]}"
do
  :
	file=$(basename $i)
	filename="${file%.*}"
	link $i $filename
done

source ~/.bashrc
