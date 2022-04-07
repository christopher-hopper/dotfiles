
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Aliases.
if [[ -f "${HOME}/.bash_aliases" ]]; then
  source "${HOME}/.bash_aliases"
fi

# Customize to your needs...

export HISTORY_SUBSTRING_SEARCH_PREFIXED=1

export EDITOR=vim
export VISUAL="$EDITOR"

export PHPENV_ROOT="${HOME}/.phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
  export PATH="${PHPENV_ROOT}/bin:${PATH}"
  eval "$(phpenv init -)"
fi

