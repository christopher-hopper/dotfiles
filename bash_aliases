# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 

# ~/.bash_aliases: executed by bash(1) for login shells.

# The copy in your home directory (~/.bash_aliases) is yours,
# please feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a pull request to the dotfiles Github repository. 

# User dependent .bash_aliases file

#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #

# enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto --human-readable --classify --sort=extension --group-directories-first'

    alias grep='grep --color=auto'                # show differences in colour
    alias egrep='egrep --color=auto'              # show differences in colour
    alias fgrep='fgrep --color=auto'              # show differences in colour
    
    alias less='less -r'                          # ANSI colour support
fi

# some more ls aliases
alias ll='ls -al'                               # long list
alias la='ls -A'                                # all but . and ..

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vi='vim'                                  # use vi improved

# Drupal code sniffer
if [ -x /usr/bin/phpcs ] && [ $(/usr/bin/phpcs -i | grep -c 'Drupal') == 1 ]; then
   alias drupalcs='/usr/bin/phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,js,txt,info'
fi

# Less with vim syntax highlighting (cool)
if [ -x /usr/share/vim/vimfiles/macros/less.sh ]; then 
   alias vless='/usr/share/vim/vimfiles/macros/less.sh'
fi

