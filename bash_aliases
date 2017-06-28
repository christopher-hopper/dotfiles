# vim: ft=sh ts=4 sw=3
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.

# ~/.bash_aliases: executed by bash(1) for login shells.

# The copy in your home directory (~/.bash_aliases) is yours,
# please feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a pull request to the dotfiles Github repository. 
#
# To override an alias instruction shown below use a \ before, ie
# \rm will call the real rm not the alias.

LSIGNORE='';
if [ "$OS" == "cygwin" ] || [ "$OS" == "Windows_NT" ]; then
    LSIGNORE="--human-readable --classify --sort=extension --group-directories-first"
    # On Windows, setup various folders to be ignored in ls commands.
    # This is to hide garbage in my %UserProfile% folder.
    LSIGNORE="$LSIGNORE -I NTUSER.DAT\* -I ntuser.dat\* -I AppData\* -I Cookies\*"
    LSIGNORE="$LSIGNORE -I ntuser.ini -I NetHood -I PrintHood -I Searches"
    LSIGNORE="$LSIGNORE -I Application\ Data -I Contacts -I Local\ Settings"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    LSIGNORE="-Gh"
fi

# enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

   alias ls="ls $LSIGNORE --color=auto"
   alias grep='grep --color=auto'
   alias egrep='egrep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias less='less -r'
else
   alias ls="ls $LSIGNORE"
fi

# Interactive file-system operations.
# alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

# List command shorthand.
alias dir='ls --format=vertical'
alias ll='ls -al'
alias la='ls -A'

# Disk usage with human readable figures.
alias df='df -h'
alias du='du -h'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# use vi improved
alias vi='vim'

# Drupal code sniffer
if [ -x /usr/local/bin/phpcs ] && [ $(/usr/local/bin/phpcs -i | grep -c 'Drupal') == 1 ]; then
   alias drupalcs='/usr/local/bin/phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,js,txt,info'
fi

# Less with vim syntax highlighting (cool)
if [ -x /usr/share/vim/vimfiles/macros/less.sh ]; then
   alias vless='/usr/share/vim/vimfiles/macros/less.sh'
elif [ -x "$HOME/.vim/macros/less.sh" ]; then
   alias vless="$HOME/.vim/macros/less.sh"
fi

