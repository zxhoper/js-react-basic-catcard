#!/bin/bash

# option_label: Run the app (install dependencies if necessary)
# option_prior: 1

main (){

  #cd js-react-basic

  if ! [ -d node_modules ] ; then
    npm install
  fi

  npm run start



}

# 2024-07-23_092016 zx-bash-utils with DeNtGr
COLOR_RED='\033[0;31m'
COLOR_GRN='\033[0;32m'
COLOR_YEL='\033[0;33m'
COLOR_BLU='\033[0;34m'
COLOR_PUR='\033[0;35m'
COLOR_NON='\033[0m' # No Color
function Note () { echo do-nothing-just-note >/dev/null ; }
function NtNo () { echo "$1" ; }
function NtRe () { echo -e "${COLOR_RED}$1${COLOR_NON}"; }
function NtGr () { echo -e "${COLOR_GRN}$1${COLOR_NON}"; }
function NtYe () { echo -e "${COLOR_YEL}$1${COLOR_NON}"; }
function NtBl () { echo -e "${COLOR_BLU}$1${COLOR_NON}"; }
function NtPu () { echo -e "${COLOR_PUR}$1${COLOR_NON}"; }
function PfNo () { printf "${COLOR_NON}%s${COLOR_NON}" "$1"; }
function PfRe () { printf "${COLOR_RED}%s${COLOR_NON}" "$1"; }
function PfGr () { printf "${COLOR_GRN}%s${COLOR_NON}" "$1"; }
function PfYe () { printf "${COLOR_YEL}%s${COLOR_NON}" "$1"; }
function PfBl () { printf "${COLOR_BLU}%s${COLOR_NON}" "$1"; }
function PfPu () { printf "${COLOR_PUR}%s${COLOR_NON}" "$1"; }
function NtTitle(){ echo ; msg="$1" ; msglen=${#msg} ; echo "$msg" ; printf -- "=%.0s" $(seq 1 $msglen) ; echo ""; }
function SectionStart () { printf "${COLOR_YEL}====================== %s ======================\\\\\\\\${COLOR_NON}\n" "$1"; }
function SectionEnded () { printf "${COLOR_NON}====================== %s ======================//${COLOR_NON}\n" "$1"; }
function ___D () { [ "$MYDEBUG" == "on" ] && return 0 || return 1 ; }
function DeNtNo () { ! [ "$MYDEBUG" == "on" ] && return 0; echo "$1" ; }
function DeNtRe () { ! [ "$MYDEBUG" == "on" ] && return 0; echo -e "${COLOR_RED}$1${COLOR_NON}"; }
function DeNtGr () { ! [ "$MYDEBUG" == "on" ] && return 0; echo -e "${COLOR_GRN}$1${COLOR_NON}"; }
function DeNtYe () { ! [ "$MYDEBUG" == "on" ] && return 0; echo -e "${COLOR_YEL}$1${COLOR_NON}"; }
function DeNtBl () { ! [ "$MYDEBUG" == "on" ] && return 0; echo -e "${COLOR_BLU}$1${COLOR_NON}"; }
function DeNtPu () { ! [ "$MYDEBUG" == "on" ] && return 0; echo -e "${COLOR_PUR}$1${COLOR_NON}"; }
function DePfNo () { ! [ "$MYDEBUG" == "on" ] && return 0; printf "${COLOR_NON}%s${COLOR_NON}" "$1"; }
function DePfRe () { ! [ "$MYDEBUG" == "on" ] && return 0; printf "${COLOR_RED}%s${COLOR_NON}" "$1"; }
function DePfGr () { ! [ "$MYDEBUG" == "on" ] && return 0; printf "${COLOR_GRN}%s${COLOR_NON}" "$1"; }
function DePfYe () { ! [ "$MYDEBUG" == "on" ] && return 0; printf "${COLOR_YEL}%s${COLOR_NON}" "$1"; }
function DePfBl () { ! [ "$MYDEBUG" == "on" ] && return 0; printf "${COLOR_BLU}%s${COLOR_NON}" "$1"; }
function DePfPu () { ! [ "$MYDEBUG" == "on" ] && return 0; printf "${COLOR_PUR}%s${COLOR_NON}" "$1"; }
function DeNtVar (){ ! [ "$MYDEBUG" == "on" ] && return 0; echo " --> Variable [\$$1] => \"$(eval echo \"\$$1\")\"" >&2 ; }

function trim() {
    local p_var="$*"
    local p_res=""
    # remove leading and trailing whitespace characters

    p_res="$( printf "${p_var}" | awk -v p_lead='^[ \t]+' -v p_end='[ \t]+$' -v p_rep='' 'BEGIN {note=Trim_lead_and_trailing_space_and_tabs} { gsub(p_lead,p_rep); gsub(p_end,p_rep) ; print $0 }')"

    printf '%s' "$p_res"
}

###################
main "$@"
###################

