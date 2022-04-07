
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

# phpenv
#
export PHPENV_ROOT="${HOME}/.phpenv"
if [[ -d "${PHPENV_ROOT}" ]]; then
  export PATH="${PHPENV_ROOT}/bin:${PATH}"
  eval "$(phpenv init -)"
fi

