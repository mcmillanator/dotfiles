#!/bin/bash
cat templates/main > ../config
if [ -z "$1" ]
then
	cat templates/home >> ../config
else
	cat templates/$1 >> ../config
fi
i3-msg reload
