command -v starship 2>&1 > /dev/null
if [ $? -eq 0 ]
then
  eval "$(starship init zsh)"
fi
