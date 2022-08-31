# vim: ft=sh ts=4 sw=2
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

# Python Pipenv.
if command -v python 1>/dev/null && [[ -d "$(python -m site --user-base 2>/dev/null)"/bin ]]; then
   PATH="$(python -m site --user-base)/bin:${PATH}"
   export PATH
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
