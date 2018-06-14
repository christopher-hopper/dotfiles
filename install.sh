#!/bin/bash
# vim: ft=sh ts=4 sw=3
function install_dotfiles
{
DOTREAL="$(readlink -f "${0}")";
DOTPATH="${DOTREAL%/*}";
DOTBAKX="orig~";
BAKLIST=();

for FILE in $DOTPATH/bash_* $DOTPATH/*rc $DOTPATH/*.conf; do
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
unset install_dotfiles;
exit 0;
