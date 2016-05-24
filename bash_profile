# vim: ft=sh ts=4 sw=3
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.

# ~/.bash_profile: executed by bash(1) for login shells.

# The copy in your home directory (~/.bash_profile) is yours,
# please feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a pull request to the dotfiles Github repository.

# User dependent .bash_profile file

# Source the users profile if it exists.
[[ -f "${HOME}/.profile" ]] && . "${HOME}/.profile";

# Source the users bashrc if it exists.
[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc";

