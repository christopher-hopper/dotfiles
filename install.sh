#!/bin/bash
# vim: ft=sh ts=4 sw=3

DOTREAL="$(readlink -f $0)";
DOTPATH="${DOTREAL%/*}";
DOTBAKX="orig~";

for FILE in $DOTPATH/bash*; do
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
   elif [ -f "$HOME/.${FILE##*/}" ]; 
   then
      echo -n " -> Delete";
      rm "$HOME/.${FILE##*/}";
   fi;
   
   echo " -> Copy";
   cp $FILE  "$HOME/.${FILE##*/}";
done;

