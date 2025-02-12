# Source chruby
command -v chruby 2>&1 > /dev/null
if [ $? -ne 0 ]
then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby
fi
