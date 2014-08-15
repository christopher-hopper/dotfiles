if [ -n "$BASH_VERSION" -o -n "$KSH_VERSION" -o -n "$ZSH_VERSION" ]; then
  [ -x /usr/share/vim/vimfiles/macros/less.sh ] || return
  alias vless >/dev/null 2>&1 || alias vless='/usr/share/vim/vimfiles/macros/less.sh'
fi
