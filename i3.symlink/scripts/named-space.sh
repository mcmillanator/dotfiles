#!/bin/bash
list="web music chat $@"

prompt () {
	prompt=`echo $list | sed 's/ /\n/g' | dmenu -i -p "Select or create a workspace"`
}

switch () {
	~/.i3/scripts/workspace.sh "$@"
}

terminal() {
	~/.i3/scripts/terminal.sh "$@"
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
		terminal $prompt
	esac
}

pick
