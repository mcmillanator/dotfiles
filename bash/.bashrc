source ~/.dotfiles_location
source $DOTFILES/bash/*

# chruby
source /usr/local/share/chruby/chruby.sh

# load ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent`
    ssh-add
fi

