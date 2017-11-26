#!/bin/bash
DOTFILES=`pwd`
echo "export DOTFILES=$DOTFILES" > ~/.dotfiles_config

files=($(find . -d 2 -type f -name '\.*' -print))

for i in "${files[@]}"
do
  :
  ln -sf $DOTFILES/$i ~/ 
done

source ~/.bashrc
