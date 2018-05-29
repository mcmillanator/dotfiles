#! /bin/bash

if i3-msg -t get_workspaces | grep \"name\":\"$1\"; then
	i3-msg -q workspace $1
else
	i3-msg -q workspace $1
	i3-msg -q exec "$2"
fi
