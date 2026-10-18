# init mcfly https://github.com/cantino/mcfly
command -v mcfly 2>&1 > /dev/null
if [ $? -eq 0 ]
then
  source <(mcfly init zsh)
fi
