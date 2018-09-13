#!/bin/bash
dir=`pwd`
WORKING_DIR=~/Projects/rails/blog
i3-msg "workspace 2; append_layout $dir/workspace1.json"
gnome-terminal --working-directory $WORKING_DIR --class blog-vim -e "bash -c 'vim ; exec bash'" &
gnome-terminal --working-directory $WORKING_DIR --class blog-term -e "bash -c 'rails c ; exec bash'" &
