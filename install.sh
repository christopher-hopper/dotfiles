#!/bin/bash
# vim: ft=sh ts=4 sw=3

#######################################
# Globals
#
# Set variables for current file, directory.
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"
__invocation="$(printf %q "${__file}")$( (($#)) && printf ' %q' "$@")"

# Default level for log output.
LOG_LEVEL="${LOG_LEVEL:-5}";
NO_COLOR=true;
DRY_RUN=false;

#######################################
# Cleanup before exit
# Trap signal EXIT
#
# Globals:
#   web_root
# Arguments:
#   None
# Returns:
#   None
__cleanup_before_exit ()
{
  info "Cleaning up. Done!"
}
trap __cleanup_before_exit EXIT

#######################################
# Log
#
# Globals:
#   None
# Arguments:
#   log_level
#   log_line[, ...]
# Returns:
#   None
#######################################
__log () {
  local log_level="${1}"
  shift

  # shellcheck disable=SC2034
  local color_debug="\\x1b[35m"
  # shellcheck disable=SC2034
  local color_info="\\x1b[32m"
  # shellcheck disable=SC2034
  local color_notice="\\x1b[34m"
  # shellcheck disable=SC2034
  local color_warning="\\x1b[33m"
  # shellcheck disable=SC2034
  local color_error="\\x1b[31m"
  # shellcheck disable=SC2034
  local color_critical="\\x1b[1;31m"
  # shellcheck disable=SC2034
  local color_alert="\\x1b[1;33;41m"
  # shellcheck disable=SC2034
  local color_emergency="\\x1b[1;4;5;33;41m"

  local colorvar="color_${log_level}"

  local color="${!colorvar:-${color_error}}"
  local color_reset="\\x1b[0m"

  if [[ "${NO_COLOR:-}" = true ]] || ( [[ "${TERM:-}" != "xterm"* ]] && [[ "${TERM:-}" != "screen"* ]] ) || [[ ! -t 2 ]]; then
    if [[ "${NO_COLOR:-}" != false ]]; then
      # Don't use colors on pipes or non-recognized terminals
      color=""; color_reset=""
    fi
  fi

  # All remaining arguments are to be printed.
  local log_line=""
  local timestamp=""
  if [[ "${LOG_LEVEL:-0}" -ge 7 ]]; then
     timestamp="[$(date -u +"%Y-%m-%d %H:%M:%S")] ";
  fi

  while IFS=$'\n' read -r log_line; do
    echo -e "${timestamp}${color}$(printf "[%9s]" "${log_level}")${color_reset} ${log_line}" 1>&2
  done <<< "${@:-}"
}

emergency () {                                  __log emergency "${@}"; exit 1; }
alert ()     { [[ "${LOG_LEVEL:-0}" -ge 1 ]] && __log alert "${@}"; true; }
critical ()  { [[ "${LOG_LEVEL:-0}" -ge 2 ]] && __log critical "${@}"; true; }
error ()     { [[ "${LOG_LEVEL:-0}" -ge 3 ]] && __log error "${@}"; true; }
warning ()   { [[ "${LOG_LEVEL:-0}" -ge 4 ]] && __log warning "${@}"; true; }
notice ()    { [[ "${LOG_LEVEL:-0}" -ge 5 ]] && __log notice "${@}"; true; }
info ()      { [[ "${LOG_LEVEL:-0}" -ge 6 ]] && __log info "${@}"; true; }
debug ()     { [[ "${LOG_LEVEL:-0}" -ge 7 ]] && __log debug "${@}"; true; }

#######################################
# install dotfiles
#
# Install the dotfiles into the current user home directory.
#
# @return string
#   Logging of installation steps and result.
install_dotfiles ()
{
local DOTPATH;
local DOTBAKX;
local BAKLIST;
local OUTLINE;

DOTPATH="${__dir}";
DOTBAKX="orig~";
BAKLIST=();

debug "
dotfiles installer

    Invoked: $__invocation
    Path:    $__dir
    Backups: *.${DOTBAKX}
    Logging: $LOG_LEVEL
"

for FILE in $DOTPATH/bash* $DOTPATH/*.conf; do
   OUTLINE="${FILE##*/}";
   if [[ "$FILE" == *${0##*/} ]]; then
      info "${OUTLINE} -> Skip";
      continue;
   fi

   if [ -h "$HOME/.${FILE##*/}" ];
   then
      OUTLINE="${OUTLINE} -> Unlink";
      [[ "$DRY_RUN" != true ]] && debug "$(2>&1 unlink "$HOME/.${FILE##*/}")";
   elif [ -f "$HOME/.${FILE##*/}" ];
   then
      OUTLINE="${OUTLINE} -> Backup ";
      [[ "$DRY_RUN" != true ]] && debug "$(2>&1 mv -v "$HOME/.${FILE##*/}" "$HOME/.${FILE##*/}.${DOTBAKX}")";
      BAKLIST=("${BAKLIST[@]}" "$HOME/.${FILE##*/}");
   elif [ -f "$HOME/.${FILE##*/}" ];
   then
      OUTLINE="${OUTLINE} -> Delete";
      [[ "$DRY_RUN" != true ]] && debug "$(rm -v "$HOME/.${FILE##*/}")";
   fi;

   OUTLINE="${OUTLINE} -> Copy";
   [[ "$DRY_RUN" != true ]] && debug "$(cp -v "$FILE"  "$HOME/.${FILE##*/}")";

   info "${OUTLINE}"
done;

if [[ "$DRY_RUN" != true ]] && [[ ${#BAKLIST[@]} -gt 0 ]] && command -v diff 1>/dev/null; then
   for FILE in "${BAKLIST[@]}"; do
      DIFFLINE="$(diff --minimal --context=2 --from-file="${FILE}.${DOTBAKX}" "$FILE")";
      if [[ "${DIFFLINE// }" != "" ]]; then
         info "$FILE -> Changed\n\n$DIFFLINE";
      else
         info "$FILE -> Unchanged";
      fi
   done;
fi;
}

usage_help ()
{
1>&2 echo <<-EOHELP || true
Usage:
  ${__base}.sh [-hn] [-v|vv|vvv] [--help|--verbose|--dryrun|--ansi]

Options:
 -h
 --help      Show this help.

 -v
 --verbose   More verbose output.

 -n
 --dryrun    No changes but show result.

 --ansi      Force ANSI (color) output.

EOHELP
exit 1;
}

#######################################
# Main
#

# Get options and arguments.

TMP_OPT=$(getopt -o hvn --long verbose,help,dryrun,ansi -n "${__base}.sh" -- "$@");
eval set -- "$TMP_OPT"

while [[ $# -gt 0 ]]; do
   case ${1} in
      -h | --help )
         usage_help;
         shift ;;
      --ansi )
         NO_COLOR=false;
         shift ;;
      -v | --verbose )
         LOG_LEVEL=$((LOG_LEVEL+1));
         shift ;;
      -n | --dryrun )
         DRY_RUN=true;
         [[ "$LOG_LEVEL" -lt 6 ]] && LOG_LEVEL=6;
         shift ;;
      -- )
         shift; break ;;
      *  )
         notice "Unknown option: $1";
         break ;;
   esac
done
shift $((OPTIND -1))

install_dotfiles;

exit 0;
