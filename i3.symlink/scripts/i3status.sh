#!/bin/bash
# TODO: create loop for multiple interfaces
adapter=`ifconfig -s | grep -v lo | awk '{if(NR>1) print $1}'`
sed "s/\$interface/$adapter/g" ../ethernet.template > ../i3status.conf.symlink
cat ../i3status.conf.template >> ../i3status.conf.symlink
