if ! tmux -v tmux %> /dev/null
then
  if [ "$TMUX" = "" ]
    then
      tmux
  fi
else
  exit 0
fi

