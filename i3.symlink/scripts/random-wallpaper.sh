#! /bin/bash
dir=$1
[[ $dir == '' ]] && dir=~/Pictures/wallpapers
list=$(locate $dir)
# locate is faster, but the given dir may not be in the db. Fall back to find if locate gives a non zero exit
if [ $? -ne 0 ]
then
	list=$(find $dir)
fi
imgs=($(file $list | grep -e image | awk -F: '{gsub(" ", "\\ ");print $1}'))
number=$RANDOM
range=${#imgs[*]}

let "number %= range"

feh --bg-scale "${imgs[$number]}"
