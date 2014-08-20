# vim: ft=sh ts=4 sw=4
# Functions to generate a pretty useful bash prompt

# Check for interactive bash 
[ -z "$BASH_VERSION" -a -z "$KSH_VERSION" -o -z "$PS1" ] && return

# Check for tput color support
[ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null || return

#
# Fancy PWD display function
#
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
#
bash_prompt_command() {
   # How many characters of the $PWD should be kept
   local pwdmaxlen=25
   # Indicate that there has been dir truncation
   local trunc_symbol=".."
   local dir=${PWD##*/}
   pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
   NEW_PWD=${PWD/#$HOME/\~}
   local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
   if [ ${pwdoffset} -gt "0" ];
   then
      NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
      NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
   fi
   # Display git prompt if available.
   GIT_PS1='';
   if [ $(type -t "__git_ps1") ]; 
   then
      GIT_PS1=$(__git_ps1);
   fi
   # Display drush prompt if available. 
   DRUSH_PS1='';
   if [ $(type -t "__drush_ps1") ]; 
   then
      DRUSH_PS1=$(__drush_ps1 " [%s]");
   fi
}

bash_prompt() {
   case $TERM in
      xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}${GIT_PS1}${DRUSH_PS1}\007\]';
         ;;
      *)
         local TITLEBAR="";
         ;;
   esac
   local NONE="$(tput sgr0)"      # unsets color to term's fg color

   # regular colors
   local K="$(tput setaf 0)"      # black
   local R="$(tput setaf 1)"      # red
   local G="$(tput setaf 2)"      # green
   local Y="$(tput setaf 3)"      # yellow
   local B="$(tput setaf 4)"      # blue
   local M="$(tput setaf 5)"      # magenta
   local C="$(tput setaf 6)"      # cyan
   local W="$(tput setaf 7)"      # white

   # emphasized (bolded) colors
   local EMK="$(tput setaf 0; tput bold)"
   local EMR="$(tput setaf 1; tput bold)"
   local EMG="$(tput setaf 2; tput bold)"
   local EMY="$(tput setaf 3; tput bold)"
   local EMB="$(tput setaf 4; tput bold)"
   local EMM="$(tput setaf 5; tput bold)"
   local EMC="$(tput setaf 6; tput bold)"
   local EMW="$(tput setaf 7; tput bold)"

   # background colors
   local BGK="$(tput setab 0)"
   local BGR="$(tput setab 1)"
   local BGG="$(tput setab 2)"
   local BGY="$(tput setab 3)"
   local BGB="$(tput setab 4)"
   local BGM="$(tput setab 5)"
   local BGC="$(tput setab 6)"
   local BGW="$(tput setab 7)"

   local UC=$G                   # user name's color
   local MC=$C                   # machine name's color
   local PC=$EMB                 # path's color
   local GC=$EMM                 # git information color
   local DC=$EMY                 # Drupal information color

   [ $UID -eq "0" ] && UC=$R     # root's color

   PS1="${TITLEBAR}\n${EMK}[${UC}\u${EMK}@${MC}\h ${PC}\${NEW_PWD}${GC}\${GIT_PS1}${DC}\${DRUSH_PS1}${EMK}]\n${UC}\\$ ${NONE}"
   # without colors: PS1="[\u@\h \${NEW_PWD}\${GIT_PS1}\${DRUSH_PS1}]\\$ "
   # extra backslash in front of closing \$ to make bash colorize the prompt
}

# Enable the prompt. 
# Execute this command every time a prompt is drawn
export PROMPT_COMMAND=bash_prompt_command
# Define the text to display beside the prompt
bash_prompt
# Clean-up the functions we no-longer require
unset bash_prompt
