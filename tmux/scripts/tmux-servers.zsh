#!/usr/bin/zsh
socket_name=$(ls /tmp/tmux-1000 | fzf --tmux --prompt='Choose socket_name: ')
# Check if tmux socket_name for socket (-L) is running by combining socket check and process check
if [[ -S "/tmp/tmux-$(id -u)/$socket_name" ]] && tmux -S "/tmp/tmux-$(id -u)/$socket_name" list-sessions >/dev/null 2>&1; then
  # if a tmux session is found
  if [[ -n "${TMUX}" ]]; then
    tmux detach-client -E "tmux -S /tmp/tmux-$(id -u)/$socket_name attach-session"
    exit
  else
    tmux -S /tmp/tmux-$(id -u)/$socket_name attach-session
    exit
  fi
fi

