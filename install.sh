#!/bin/bash
DOTFILES=`pwd`
echo "export $DOTFILES" > ~/.dotfiles_location

files=($(find . -d 2 -type f -name '\.*' -print))

for i in "${files[@]}"
do
  :
  ln -s $DOTFILES/$i ~/ 
done
