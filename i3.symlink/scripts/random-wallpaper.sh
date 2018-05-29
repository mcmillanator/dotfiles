#! /bin/bash
dir=$1
#imgs=(`find $dir -type f -name *.png`)
imgs=($(find $dir -type f -exec file {} + | grep -e image | awk -F: '{gsub(" ","\\ ");print $1}'))

number=$RANDOM
range=${#imgs[*]}

let "number %= range"

feh --bg-scale "${imgs[$number]}"