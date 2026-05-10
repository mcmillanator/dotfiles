# vars
prebuiltTags=(mcmillanator/prebuilt-base mcmillanator/prebuilt-ts mcmillanator/prebuilt-tf mcmillanator/prebuilt-python mcmillanator/prebuilt-ruby)
gitSha=$(git rev-parse --short HEAD)
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
alias fzf-log='fzf --tail 100000 --tac --no-sort --exact --wrap'
alias tmux='tmux -L $(hostname)'

alias areslogs='ssh ares -t "cd prc ; invoke logs"'
alias aresprc='ssh ares -t "cd prc ; zsh"'

alias vpnservicedown='sudo systemctl stop perimeter81helper'
alias vpnserviceup='sudo systemctl start perimeter81helper'
alias vpnservicestatus='sudo systemctl status perimeter81helper'
alias vpnservicerestart='sudo systemctl restart perimeter81helper'
alias vpn-disconnect='/usr/bin/p81-helper-daemon ctl vpn-disconnect'
alias vpn-connect='/usr/bin/p81-helper-daemon ctl vpn-connect'
alias vpn-status='/usr/bin/p81-helper-daemon ctl vpn-status'
alias vpnps='pgrep -fai perimeter81'
alias vpnkill='vpnservicedown ; pkill -i -9 perimeter81'
alias vpnroutes='ip route show | grep -i -E "(^44|^54)"'

vpnsubnets()
{
  vpnroutes | awk '{print $1}'
}
vpndelroutes()
{
  for i in $(vpnsubnets)
    sudo ip route del $i
}

alias dockerdown='sudo systemctl stop docker'
alias dockerup='sudo systemctl start docker'
alias dockerrestart='sudo systemctl restart docker'
alias dockernetworknames="docker network ls --format '{{.Name}}'"
alias dockersubnet="docker network inspect $1 --format '{{(index .IPAM.Config 0).Subnet}}'"

# ruby
alias be='bundle exec $@'

# python
alias python='python3'

# devcontainers
dcbash()
{
  FILE=$(check_for_file ".devcontainer/devcontainer.json")
  if [ -z "$1" ]; then
    devcontainer exec --workspace-folder . --override-config $FILE bash 
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc bash 
  fi
}

dc()
{
  FILE=$(check_for_file ".devcontainer/devcontainer.json")

  if [ -z "$1" ]; then
    cmd="/usr/bin/zsh"
  else
    cmd="$1"
  fi

  if [ -z "$2" ]; then
    devcontainer exec --workspace-folder . --override-config $FILE $cmd
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc $cmd
  fi
}

dczsh()
{
  FILE=$(check_for_file ".devcontainer/devcontainer.json")
  if [ -z "$1" ]; then
    devcontainer exec --workspace-folder . --override-config $FILE  /usr/bin/zsh
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc  /usr/bin/zsh
  fi
}
dcnvim()
{
  FILE=$(check_for_file ".devcontainer/devcontainer.json")
  if [ -z "$1" ]; then
    devcontainer exec --workspace-folder . --override-config $FILE nvim
  else
    devcontainer exec --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc nvim
  fi
}

dcup()
{
  FILE=$(check_for_file ".devcontainer/devcontainer.json")
  if [ -z "$1" ]; then
    devcontainer --remove-existing-container --user-data-folder="${HOME}/.local/share/devcontainer-user-data" --dotfiles-repository="https://github.com/mcmillanator/dotfiles.git" --dotfiles-install-command="install.sh" --workspace-folder . --override-config $FILE up
  else
    devcontainer --remove-existing-container --user-data-folder="${HOME}/.local/share/devcontainer-user-data" --dotfiles-repository="https://github.com/mcmillanator/dotfiles.git" --dotfiles-install-command="install.sh" --workspace-folder . --override-config $HOME/.devcontainers/$1.jsonc up
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

check_for_file()
{
  FILE="$1"
  if [[ -f "$FILE" ]]; then
    FILE=$FILE
  elif [[ -f "${FILE}c" ]]; then
      FILE="${FILE}c"
  else
    return 1
  fi
  echo "$FILE"
}

dcbuild ()
{
  image_name="mcmillanator/$(name_from_pwd):latest"
  if [ -n "$2" ]; then
    image_name="$2"
  fi

  FILE=$(check_for_file ".devcontainer/devcontainer.json")

  if [ -z "$1" ]; then
    devcontainer --workspace-folder . --config $FILE build --image-name=$image_name
  else
    devcontainer --workspace-folder . --config $HOME/.devcontainers/$1.jsonc --image-name=$image_name build
  fi
}

dcprebuildpush()
{
  local results=""

  dctags
  for i in ${prebuiltTags}
  docker tag "$i":latest "$i":$gitSha
  docker push "$i":$gitSha && results="$results\n$i: Success" || results="$results\n$i: Failed"
  docker push "$i":latest && results="$results\n$i: Success" || results="$results\n$i: Failed"

  echo $results
}

dctags()
{
  for i in $prebuiltTags
  docker tag "$i":latest "$i":$gitSha
}

dcprebuild()
{
  local results=""

  dcbuild prebuilt/base mcmillanator/prebuilt-base:latest && results="$results\nprebuilt/base: Success" || results="$results\nprebuilt/base: Failed"
  dcbuild prebuilt/python mcmillanator/prebuilt-python:latest && results="$results\nprebuilt/python: Success" || results="$results\nprebuilt/python: Failed"
  dcbuild prebuilt/ts mcmillanator/prebuilt-ts:latest && results="$results\nprebuilt/ts: Success" || results="$results\nprebuilt/ts: Failed"
  dcbuild prebuilt/tf mcmillanator/prebuilt-tf:latest && results="$results\nprebuilt/tf: Success" || results="$results\nprebuilt/tf: Failed"
  dcbuild prebuilt/ruby mcmillanator/prebuilt-ruby:latest && results="$results\nprebuilt/ruby: Success" || results="$results\nprebuilt/ruby: Failed"

  echo -e "$results"

  dctags
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

dockersubnets()

{
  for i in $(dockernetworknames)
    if [[ $i != "none" ]] && [[ $i != "host" ]]; then
      echo $i $(dockersubnet $i)
    fi
}
