#!/bin/bash
DOTFILES=`pwd`
echo "export DOTFILES=$DOTFILES" > ~/.dotfiles_config
files=($(find . -type f -name '*.symlink' -print))
files+=(vim)

function link () {
	ln -sfn $DOTFILES/$1 ~/.$2
}


for i in "${files[@]}"
do
  :
	file=$(basename $i)
	filename="${file%.*}"
	link $i $filename
done

source ~/.bashrc
