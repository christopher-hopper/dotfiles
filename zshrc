# vim: ft=bash ts=4 sw=2
#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Aliases.
if [[ -f "${HOME}/.bash_aliases" ]]; then
  source "${HOME}/.bash_aliases"
fi

# Customize to your needs...
#
export HISTORY_SUBSTRING_SEARCH_PREFIXED=1

# Erase history in current session.
function erase_history {
  local HISTSIZE=0;
}
function zshaddhistory_erase_history {
  [[ $1 != [[:space:]]#erase_history[[:space:]]# ]]
}
zshaddhistory_functions+=(zshaddhistory_erase_history)

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

# Editor Options
#
# Set the default text editor to use with various
# programs and commands.
export EDITOR='vim';
export VISUAL="$EDITOR";

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

