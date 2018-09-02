#! /bin/bash

terminal() {
	i3-sensible-terminal -e "bash -c '${1} ; exec bash'"
}

workspace() {
	i3-msg -q workspace $1
}

app() {
	i3-msg -q exec "$1"
}

name=$1
shift
workspace $name
while getopts a:t: opt; do
	case $opt in
		t)
			 terminal "$OPTARG"
			;;
		a)
			app "$OPTARG"
			;;
	esac
done
