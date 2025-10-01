command -v direnv 2>&1 > /dev/null
if [ $? -eq 0 ]
then
  eval "$(direnv hook zsh)"
fi
