#!/usr/bin/zsh
server=$(ls /tmp/tmux-1000 | fzf --tmux --prompt='Choose server: ')
if [[ -n "${TMUX}" ]]; then
  tmux detach-client -E "tmux -S /tmp/tmux-$(id -u)/$server attach-session"
  exit
else
  tmux -S /tmp/tmux-$(id -u)/$server attach-session
  exit
fi

