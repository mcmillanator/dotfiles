source ~/.dotfiles_config
for i in $DOTFILES/bash/*
do
  source $i
done

# chruby
source /usr/local/share/chruby/chruby.sh

# load ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent`
    ssh-add
fi

