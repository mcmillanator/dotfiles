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

# if workspace already exist then switch to it
if i3-msg -t get_workspaces | grep \"name\":\"$name\"; then
	workspace $name
# else create the workspace and parse arguments
else
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
fi
