#!/usr/bin/bash
echo "Running entrypoint as user: ${USER}"
mackup_dir=$(pwd)/.mackup
mackup_conf=$(pwd)/.mackup.cfg
if [ ! -d ~/.mackup ]; then
  echo "folder not found linking"
	ln -fs $mackup_dir ~/.mackup
fi

if [ ! -f ~/.mackup.cfg ]; then
  echo "file not found linking"
	ln -fs $mackup_conf ~/.mackup.cfg
fi
mackup restore -f
