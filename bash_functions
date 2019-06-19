# vim: ft=sh ts=4 sw=3
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.

# ~/.bash_functions: executed by bash(1) for login shells.

# The copy in your home directory (~/.bash_functions) is yours,
# please feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the dotfiles maintainers.

# User dependent .bash_functions file

# Some example functions:
#
# function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }

# History update
#
# Reads the history file into the current shell. Useful for
# updating the history after closing a shell open in
# another terminal.
histupdate ()
{
   # Remove the last entry from history list
   TMP="$(history | tail -1 | cut -f 2,2 -d ' ')" && test -n "$TMP" && history -d "$TMP"
   # Append new lines to history file
   history -a
   # Read new lines into history list
   history -n
}

