#! /bin/bash
[ $(echo -e "No\nYes" | dmenu -i -p "$1") == "Yes" ] && bash -c "$2"
