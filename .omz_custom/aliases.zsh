# nivm
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
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
dcbash()
{
  if [ -z "$1" ]; then
    devcontainer exec --workspace-folder . --override-config .devcontainer/devcontainer.json bash 
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc bash 
  fi
}

dczsh()
{
  if [ -z "$1" ]; then
    devcontainer exec --workspace-folder . --override-config .devcontainer/devcontainer.json  /usr/bin/zsh
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc  /usr/bin/zsh
  fi
}
dcnvim()
{
  if [ -z "$1" ]; then
    devcontainer exec --workspace-folder . --override-config .devcontainer/devcontainer.json nvim
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc nvim
  fi
}

dcup()
{
  if [ -z "$1" ]; then
    devcontainer --workspace-folder . --override-config .devcontainer/devcontainer.json up
  else
    devcontainer --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc up
  fi
}

dcsetup()
{
  devcontainer --config $HOME/.devcontainers/$1.jsonc --container-id=$2 set-up 
  #--dotfiles-repository            URL of a dotfiles Git repository (e.g., https://github.com/owner/repository.git)
  #                                                                                                              [string]
  #--dotfiles-install-command       The command to run after cloning the dotfiles repository. Defaults to run the first f
  #                                 ile of `install.sh`, `install`, `bootstrap.sh`, `bootstrap`, `setup.sh` and `setup` f
  #                                 ound in the dotfiles repository`s root folder.                               [string]
  #--dotfiles-target-path           The path to clone the dotfiles repository to. Defaults to `~/dotfiles`.
  #                                                                                      [string] [default: "~/dotfiles"]

}

dcbuild ()
{
  if [ -z "$1" ]; then
    devcontainer --workspace-folder . --config .devcontainer/devcontainer.json build
  else
    devcontainer --workspace-folder . --config $HOME/.devcontainers/$1.jsonc --image-name="${1:gs/\//-}:latest" build
  fi
}

dcprebuild()
{
  dcbuild prebuilt/base
  dcbuild prebuilt/tf || true
  dcbuild prebuilt/python || true
  dcbuild prebuilt/ruby || true
}
