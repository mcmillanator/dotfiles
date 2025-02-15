#!/usr/bin/zsh
echo "Starting script"
server=$(ls /tmp/tmux-1000 | fzf --tmux --prompt='Choose server: ')
echo "Server choosen"
if [[ -n "${TMUX}" ]]; then
  tmux detach-client -E "tmux -S /tmp/tmux-$(id -u)/$server attach-session"
else
  tmux -S /tmp/tmux-$(id -u)/$server attach-session
fi
echo "Tmux server switched"

