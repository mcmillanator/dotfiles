#!/bin/bash
adapter=`ifconfig -s | grep -v lo | awk '{if($3>0) print $1}' | awk '{if(NR>1) print }'`
adapter=`ifconfig | grep $adapter | awk '{print $1}' | sed 's/://g'`
sed "s/\$interface/$adapter/g" ~/.i3/ethernet.template > ~/.i3/i3status.conf.symlink
cat ~/.i3/i3status.conf.template >> ~/.i3/i3status.conf.symlink
