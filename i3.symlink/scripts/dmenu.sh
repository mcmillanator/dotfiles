#!/bin/bash
function logoff() {
	i3-msg exec "~/.i3/scripts/dmenu_prompt.sh 'Log off?' 'i3-msg exit'"
}

function shutdown() {
	i3-msg exec "~/.i3/scripts/dmenu_prompt.sh 'Shutdown?' 'shutdown -P now'"
}

function suspend() {
	i3-msg exec "~/.i3/scripts/dmenu_prompt.sh 'Suspend?' 'systemctl suspend'"
}

function random_wallpaper() {
	~/.i3/scripts/random-wallpaper.sh ~/Pictures/wallpapers
}

cmd=$(printf "suspend\nshutdown\nlogoff\nrandom wallpaper" | dmenu -l 4)
${cmd/ /_}
