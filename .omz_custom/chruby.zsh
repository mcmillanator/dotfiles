# Source chruby
if command -v chruby 2>&1 > /dev/null
then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby
fi
