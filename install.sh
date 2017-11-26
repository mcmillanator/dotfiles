#!/bin/bash
echo "export DOTFILES=`pwd`" > ~/.dotfiles_location

files=($(find . -d 2 -type f -name '\.*' -print))

for i in "${files[@]}"
do
  :
  ln -s $i ~/.
done
