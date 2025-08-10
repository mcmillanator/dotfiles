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
  image_name="mcmillanator/$(name_from_pwd):latest"
  if [ -n "$2" ]; then
    image_name="$2"
  fi
  if [ -z "$1" ]; then
    devcontainer --workspace-folder . --config .devcontainer/devcontainer.json build
  else
    devcontainer --workspace-folder . --config $HOME/.devcontainers/$1.jsonc --image-name=$image_name build
  fi
}

dcprebuildpush()
{
  local results=""

  for i in $(docker images | grep mcmillanator/prebuilt | awk '{print $1}' )
  docker push $i && results="$results\n$i: Success" || results="$results\n$i: Failed"

  echo $results
}

dcprebuild()
{
  local results=""
  
  dcbuild prebuilt/base mcmillanator/prebuilt-base:latest && results="$results\nprebuilt/base: Success" || results="$results\nprebuilt/base: Failed"
  dcbuild prebuilt/ts mcmillanator/prebuilt-ts:latest && results="$results\nprebuilt/ts: Success" || results="$results\nprebuilt/ts: Failed"
  dcbuild prebuilt/tf mcmillanator/prebuilt-tf:latest && results="$results\nprebuilt/tf: Success" || results="$results\nprebuilt/tf: Failed"
  dcbuild prebuilt/python mcmillanator/prebuilt-python:latest && results="$results\nprebuilt/python: Success" || results="$results\nprebuilt/python: Failed"
  dcbuild prebuilt/ruby mcmillanator/prebuilt-ruby:latest && results="$results\nprebuilt/ruby: Success" || results="$results\nprebuilt/ruby: Failed"
  
  echo -e "$results"
}

dcrebuild()
{
  for i in $(docker ps -a | grep -i $(name_from_pwd) | awk '{print $1}')
  docker stop $i ; docker rm $i ; dcbuild $1 && dcup $1 && dczsh $1
}

dcdown()
{
  for i in $(docker ps -a | grep -i $(name_from_pwd) | awk '{print $1}')
  docker stop $i ; docker rm $i
}

name_from_pwd()
{
  echo ${(L)PWD##*/}
}
