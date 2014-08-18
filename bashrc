# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 

# ~/.bashrc: executed by bash(1) for interactive shells.

# The copy in your home directory (~/.bashrc) is yours,
# please feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a pull request to the dotfiles Github repository. 

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#

# Bash Completion
# 
# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bashrc and /etc/profile
# sources /etc/bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Append to the history file, don't overwrite it.
shopt -s histappend

# Set the History length.
export HISTSIZE=1000
export HISTFILESIZE=2000

# less 
#
# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# cd Options
#
if [ -z $CDPATH ]; then
    CDPATH='.'
fi
#[[ -d /opt/projects || -d /opt/provisioning ]] && CDPATH="$CDPATH:/opt";
export CDPATH;

# Default Editor
# 
# Set the default text editor to use with various 
# programs and commands--i.e. Subversion
export EDITOR='vim'
export SVN_EDITOR='vim'

# Aliases
#
# Some people use a different file for aliases
if [ -f "${HOME}/.bash_alias" ]; then
  . "${HOME}/.bash_alias"
fi

# Umask
#
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
if [ -f "${HOME}/.bash_function" ]; then
  . "${HOME}/.bash_function"
fi

# Command-line Prompt 
#
if [ -f "${HOME}/.bash_prompt" ]; then
  . "${HOME}/.bash_prompt"
fi
