# vim: ft=bash ts=4 sw=3
# shellcheck disable=SC1090,SC1091
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.

# ~/.bashrc: executed by bash(1) for interactive shells.

# The copy in your home directory (~/.bashrc) is yours,
# please feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the dotfiles maintainers.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# System interactive shell settings for bash
if [[ -f /etc/bashrc ]]; then
   . /etc/bashrc
fi
if [[ -f /etc/bash.bashrc ]]; then
   . /etc/bash.bashrc
fi

# Shell Options
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Completion Options
#
# These completion tuning parameters change the default behavior of
# bash_completion:
#
# Define to avoid stripping description in --option=description of
# './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files.
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
   elif [ -f /usr/local/etc/bash_completion ]; then
      . /usr/local/etc/bash_completion
   elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
   fi
fi

if [[ "${OS}" == "cygwin" ]] || [[ "${OS}" == "Windows_NT" ]]; then
   set completion-ignore-case on
fi

# History Options
#
# Ignore some controlling instructions.
#
# HISTIGNORE is a colon-delimited list of patterns which should be
# excluded. The '&' is a special pattern which suppresses duplicate
# entries.
#
# Exclude these commands from the history.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:l[sla]'
#
# Don't put duplicate lines in the history.
export HISTCONTROL="${HISTCONTROL}${HISTCONTROL+,}ignoredups"
#
# Append to the history file, don't overwrite it.
shopt -s histappend
#
# Set the History length.
export HISTSIZE=1000
export HISTFILESIZE=2000

# Path Options
#
# Set PATH so it includes local system admin programs.
if [[ -d /usr/local/sbin ]]; then
   export PATH="/usr/local/sbin:${PATH}"
fi
# Set PATH so it includes user's private bin if it exists.
if [[ -d "${HOME}/.local/bin" ]]; then
  export PATH="${HOME}/.local/bin:${PATH}"
fi
# Set MANPATH so it includes users' private man if it exists.
if [[ -d "${HOME}/.local/man" ]]; then
  export MANPATH="${HOME}/.local/man:${MANPATH}"
fi
# Set INFOPATH so it includes users' private info if it exists.
if [[ -d "${HOME}/.local/info" ]]; then
  export INFOPATH="${HOME}/.local/info:${INFOPATH}"
fi

# Set CDPATH so it includes users' home folder.
#
# Look in the current path then users' home path when changing
# directory.
[[ -n "${CDPATH}" ]] || CDPATH='.';
[[ -d "${HOME}" ]] && CDPATH="${CDPATH}:${HOME}";
# Look in the projects code path when changing directory.
#[[ -d /opt/projects ]] && CDPATH="$CDPATH:/opt/projects";
export CDPATH;

# Editor Options
#
# Set the default text editor to use with various
# programs and commands.
export EDITOR='vim';
export VISUAL="$EDITOR";

# less
#
# Make less more friendly for non-text input files, see lesspipe(1).
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Aliases
#
# Some people use a different file for aliases.
if [[ -f "${HOME}/.bash_aliases" ]]; then
   . "${HOME}/.bash_aliases"
fi

# Functions
#
# Some people use a different file for functions.
if [[ -f "${HOME}/.bash_functions" ]]; then
   . "${HOME}/.bash_functions"
fi

# Command-line Prompt
#
# Pluggable command-line prompt.
for i in "${HOME}"/.bash_prompt*; do
   if [[ -r "$i" ]] && [[ "$i" != *.orig~ ]]; then
      . "$i"
   fi
done
unset i
#
# Configure Git prompt settings.
# Allowed values described in `bash_prompt_git'.
export GIT_PS1_SHOWCOLORHINTS='';
export GIT_PS1_SHOWDIRTYSTATE='auto';
export GIT_PS1_SHOWSTASHSTATE='auto'
export GIT_PS1_SHOWUNTRACKEDFILES='';
#export GIT_PS1_SHOWUPSTREAM='verbose name';
export GIT_PS1_SHOWUPSTREAM='verbose';
export GIT_PS1_DESCRIBE_STYLE='branch';

# Apple
#
# On macOS tell ssh-add to use the keychain.
export APPLE_SSH_ADD_BEHAVIOR=macos

# Add nvm (Node Version Manager) support.
export NVM_DIR="${HOME}/.nvm"
export NVM_SYMLINK_CURRENT=true
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

# Homebrew unversioned Python.
if [[ -d "$(brew --prefix 2>/dev/null)/opt/python/libexec/bin" ]]; then
   export PATH="$(brew --prefix 2>/dev/null)/opt/python/libexec/bin:${PATH}"
fi

# Add Ruby Version Manager binaries to PATH.
if [[ -d "${HOME}/.rvm/bin" ]]; then
   export PATH="${PATH}:${HOME}/.rvm/bin"
   [[ -d "${HOME}/.rvm/scripts/rvm" ]] && \. "${HOME}/.rvm/scripts/rvm"
fi

# Add Ruby Environment switcher support.
export RBENV_ROOT="${HOME}/.rbenv"
if [[ -d "${RBENV_ROOT}" ]]; then
   eval "$(rbenv init -)"
fi

# Add PHP Environment switcher support.
export PHPENV_ROOT="${HOME}/.phpenv"
if [[ -d "${PHPENV_ROOT}" ]]; then
   export PATH="${PHPENV_ROOT}/bin:${PATH}"
   eval "$(phpenv init -)"
fi

# Add Composer global vendor binaries to PATH.
if [[ -d "$(composer global config bin-dir --absolute 2>/dev/null)" ]]; then
   PATH="${PATH}:$(composer global config bin-dir --absolute 2>/dev/null)"
   export PATH
fi

# Initialise symfony-autocomplete command completion.
if command -v symfony-autocomplete 1>/dev/null; then
   eval "$(symfony-autocomplete)"
fi

# semantic version sv4git config.
export SV4GIT_HOME="$HOME/.sv4git"

