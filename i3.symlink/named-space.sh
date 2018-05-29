#!/bin/bash
list="web music chat $@"

prompt () {
	prompt=`echo $list | sed 's/ /\n/g' | dmenu -i`
}

pick () {
	prompt
	case $prompt in
	web)
	 ~/.workspace.sh web chromium-browser
		;;
	chat)
		 ~/.workspace.sh chat "chromium-browser --new-window https://discordapp.com/channels/@me"
		;;
	music)
		 ~/.workspace.sh music "chromium-browser --new-window https://www.pandora.com"
		;;
	*)
		i3-msg -q workspace $prompt
	esac
}

pick
