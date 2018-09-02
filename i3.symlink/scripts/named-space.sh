#!/bin/bash
list="web music chat $@"

prompt () {
	prompt=`echo $list | sed 's/ /\n/g' | dmenu -i -p "Select or create a workspace"`
}

switch () {
	~/.i3/scripts/workspace.sh "$@"
}

pick () {
	prompt
	case $prompt in
	web)
		switch web -a chromium-browser
		;;
	chat)
		switch chat -a discord
		;;
	music)
		switch music -a "chromium-browser --new-window https://www.pandora.com"
		;;
	*)
		switch $prompt
	esac
}

pick
