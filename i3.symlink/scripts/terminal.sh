#! /bin/bash

while getopts n:e: opt; do
	#echo "opt: $opt"
	#echo "ARG $OPTARG"
	case $opt in
		n)
			name=$OPTARG
			;;
		e)
			command=$OPTARG
			;;
	esac
done

echo "command $command"
i3-sensible-terminal -e "bash -c '${command} ; exec bash'"
#if i3-msg -t get_workspaces | grep \"name\":\"$1\"; then
#	i3-msg -q workspace $1
#else
#	i3-msg -q workspace $1
#	for i in "${@/$1}"
#	do
#		:
#		i3-msg -q exec "$i"
#	done
#fi
