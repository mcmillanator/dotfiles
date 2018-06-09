#! /bin/bash
dir=$1
[[ $dir == '' ]] && dir=~/Pictures/wallpapers
imgs=($(file `locate $dir` | grep -e image | awk -F: '{gsub(" ", "\\ ");print $1}'))

number=$RANDOM
range=${#imgs[*]}

let "number %= range"

feh --bg-scale "${imgs[$number]}"
