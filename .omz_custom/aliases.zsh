# Oh my zsh
alias zshconfig="vim ~/.zshrc"
alias omz="cd ~/.omz_custom && nvim ; popd"
alias omzconfig="cd ~/.oh-my-zsh ; nvim && popd"

alias myip="curl http://ipecho.net/plain; echo"
alias apps="cd ~/Documents/Projects"
alias la='ls -a'
alias ll='ls -lah'

# ruby
alias be='bundle exec $@'

# python
alias python='python3'

# devcontainers
alias dcbash='devcontainer exec --workspace-folder . bash'
alias dcnvim='devcontainer exec --workspace-folder . nvim'
alias dcup='devcontainer --workspace-folder . up'
alias dcbuild='devcontainer --workspace-folder . build'
