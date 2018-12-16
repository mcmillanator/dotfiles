#!/bin/bash
git submodule init
git submodule update

DOTFILES=`pwd`
$DOTFILES/i3.symlink/scripts/i3status.sh
echo "export DOTFILES=$DOTFILES" > ~/.dotfiles_config
files=($(find . -name '*.symlink' -print))
config_files=($(find config -maxdepth 1 -print | awk '{if(NR>1) print}'))
files+=(vim .tmux/.tmux.conf)

function link () {
	rm -rf $2
	ln -sfn $DOTFILES/$1 $2
	echo "symlinked $2 to $DOTFILES/$1"
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
	link $i ~/.$file
done

mkdir -p ~/.config
for i in "${config_files[@]}"
do
  :
	file=$(parse-filename $i)
	link $i ~/.config/$file
done

source ~/.bashrc
i3-msg reload >/dev/null 2>&1
