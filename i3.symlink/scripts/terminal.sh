#! /bin/bash

terminal() {
	i3-sensible-terminal -e "bash -c '${1} ; exec bash'"
}

workspace() {
	i3-msg -q workspace $1
}

name=$1
shift
workspace $name
while getopts o:e: opt; do
	case $opt in
		e)
			 terminal "$OPTARG"
			;;
		o)
			app "$OPTARG"
			;;
	esac
done
