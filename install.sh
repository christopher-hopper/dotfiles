#!/bin/bash
# vim: ft=sh ts=4 sw=3

# install readlink
#
# OSX freeBSD friendly `readlink -f` alternative.
#
# @return string
#   Canonical path to this shell script.
function install_dotreal
{
   local ORIGPWD=$(pwd);
   local TARGET=$(basename "$0");
   cd $(dirname "$0");

   # Iterate down a (possible) chain of symlinks
   while [ -L "$TARGET" ]
   do
	  TARGET=$(readlink "$TARGET");
	  cd $(dirname "$TARGET");
	  TARGET=$(basename "$TARGET");
   done

   # Compute the canonicalized directory by printing the physical working dir.
   local CDIR=$(pwd -P);

   # Return to the original working dir.
   cd "$ORIGPWD";

   echo "$CDIR/$TARGET";
}

# install dotfiles
#
# Install the dotfiles into the current user home directory.
#
# @return string
#   Logging of installation steps and result.
function install_dotfiles
{
DOTREAL="$(install_dotreal)";
DOTPATH="${DOTREAL%/*}";
DOTBAKX="orig~";
BAKLIST=();

for FILE in $DOTPATH/bash* $DOTPATH/*.conf; do
   echo -n "${FILE##*/}";
   if [[ "$FILE" == *${0##*/} ]]; then
      echo " -> Skip";
      continue;
   fi 

   if [ -h "$HOME/.${FILE##*/}" ]; 
   then
      echo -n " -> Unlink";
      unlink "$HOME/.${FILE##*/}";
   elif [ -f "$HOME/.${FILE##*/}" ] && [ ! -f "$HOME/.${FILE##*/}.${DOTBAKX}" ]; 
   then
      echo -n " -> Backup ";
      mv -v "$HOME/.${FILE##*/}" "$HOME/.${FILE##*/}.${DOTBAKX}";
      BAKLIST=("${BAKLIST[@]}" "$HOME/.${FILE##*/}");
   elif [ -f "$HOME/.${FILE##*/}" ]; 
   then
      echo -n " -> Delete";
      rm "$HOME/.${FILE##*/}";
   fi;
   
   echo " -> Copy";
   cp "${FILE}"  "$HOME/.${FILE##*/}";
done;

if [[ ${#BAKLIST[@]} -gt 0 ]] && [[ $(which diff) != "" ]]; then
   echo;
   echo "Changes:";

   for FILE in "${BAKLIST[@]}"; do
      diff --minimal --context=2 --from-file="${FILE}.${DOTBAKX}" "$FILE";
   done;
fi;
}

install_dotfiles;
unset install_dotreal install_dotfiles;
exit 0;
