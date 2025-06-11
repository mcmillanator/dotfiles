# Source chruby
command -v chruby 2>&1 > /dev/null
if [ $? != 0 ]
  then
  if [ -f '/usr/local/share/chruby/chruby.sh' ] && [ -f '/usr/local/share/chruby/auto.sh' ]
    then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
    chruby ruby
  fi
fi
