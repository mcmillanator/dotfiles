#!/bin/bash
list="web music chat $@"

prompt () {
	prompt=`echo $list | sed 's/ /\n/g' | dmenu -i`
}

switch () {
	~/.i3/scripts/workspace.sh $1 $2
}

pick () {
	prompt
	case $prompt in
	web)
	 switch web chromium-browser
		;;
	chat)
		 switch chat "chromium-browser --new-window https://discordapp.com/channels/@me"
		;;
	music)
		 switch music "chromium-browser --new-window https://www.pandora.com"
		;;
	*)
		switch $prompt
	esac
}

pick
