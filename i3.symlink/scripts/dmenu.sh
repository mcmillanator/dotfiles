#!/bin/bash
function confirm() {
	[ $(echo -e "No\nYes" | dmenu -i -p "$1") == "Yes" ] && bash -c "$2"
}
function logoff() {
	confirm 'Log off?' 'i3-msg exit'
}

function shutdown() {
	confirm 'Shutdown?' 'shutdown -P now'
}

function suspend() {
	confirm 'Suspend?' '~/.i3/scripts/lock.sh && systemctl suspend'
}

function random_wallpaper() {
	~/.i3/scripts/random-wallpaper.sh ~/Pictures/wallpapers
}

function list_workspaces() {
	i3-msg workspace $(~/.i3/scripts/workspaces.py | dmenu)
}

function list_modes(){
	list=$(echo `i3-msg -t get_binding_modes` | sed 's/"//g
		s/,/\n/g
		s/\[//g
		s/\]//g')
		i3-msg mode $(printf "$list"	| dmenu -l `line_count "$list"`)
}

function line_count() {
	count=$(printf "${1// /_}" | wc -l)
	echo $((count+1))
}

list="suspend\nshutdown\nlogoff\nrandom wallpaper\nlist modes\nlist workspaces\n"
count=$(line_count "$list")
if [[ $1 ]] 
then
	$1
	exit
else
	cmd=`printf "$list" | dmenu -l $((count))`
	${cmd// /_}
fi
