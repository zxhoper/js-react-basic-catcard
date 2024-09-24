#!/usr/bin/env bash

# option_label: list script for choose and run
# option_prior: 9999

main (){

  Note " =-= list examples in an_example for choose and run it =-= "

  wd_path="$( pwd )"
  wd_dir="${wd_path##*/}"

  if [ -d "$wd_path/zx" ] ; then
    NtGr "  -->will list script in: $wd_dir/zx"
  else
    NtRe "  -->$0 should run inside js-react-basic.* folder, but now in: $wd_dir"
    exit 0
  fi

  all_script="$( cd zx/ && find * -maxdepth 0  -name "*" -type f )"


  scriptArr=()
  scriptArr+=( $(echo $all_script | tr '\n' ' ' ) )

  sLabel=()
  sPrior=()
  sPriorNindex=()

  idx=0
  for an_script in "${scriptArr[@]}"
  do
    if ___D ; then echo "==> $an_script" ; fi

    this_label="$(cat "zx/$an_script" | grep -E '# option_label' | head -n 1 | awk -F ':' '{print $2}' )"
    this_label="$( trim "$this_label" )"
    if [ ${#this_label} -eq 0 ] ; then this_label="$an_script" ; fi
    sLabel+=( "$this_label" )

    this_prior="$(cat "zx/$an_script" | grep -E '# option_prior' | head -n 1 | awk -F ':' '{print $2}' )"
    this_prior="$( trim "$this_prior" )"
    if [ ${#this_prior} -eq 0 ] ; then this_prior="30" ; fi
    sPrior+=( "$this_prior" )
    sPriorNindex+=(  "${this_prior}:${idx}"  )
    ((idx++))
  done

  IFS=$'\n' sPriorNindex_sorted=($(sort <<<"${sPriorNindex[*]}")); unset IFS

  idx=0
  if ___D ; then
    for s in "${scriptArr[@]}" ; do
      printf "%d, [%s]==>" "$idx"  "${s}"
      printf "[%s]==>" "${sLabel[$idx]}"
      printf "[%s]\n" "${sPrior[$idx]}"
      ((idx++))
    done
      NtPu   "  sPriorNindex_sorted:"
      printf "  =>[%s]\n" "${sPriorNindex_sorted[@]}"
  fi



  options=(    )
  idx=0
  for pni in "${sPriorNindex_sorted[@]}"; do
    pni_i="${pni#*:}"
    DeNtVar pni_i
    options+=( "${sLabel[$pni_i]}" )
    ((idx++))
  done


  echo "Select one option using up/down keys and enter to confirm:"
  echo


  select_option "${options[@]}"
  choice=$?

  echo "++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "Choosen index = $choice"
  choosen_PriorNindex="${sPriorNindex_sorted[$choice]}"
  DeNtVar choosen_PriorNindex
  choosen_script_index="${choosen_PriorNindex#*:}"
  DeNtVar choosen_script_index
  echo "        label = ${sLabel[$choosen_script_index]}"
  echo "       script = ${scriptArr[$choosen_script_index]}"
  echo "++++++++++++++++++++++++++++++++++++++++++++++++++"

  script_to_run="${scriptArr[$choosen_script_index]}"

  zx/${script_to_run}

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
##//--------------------------------------------------------------------
function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
      if [[ $key = $ESC[A ]]; then echo up;    fi
      if [[ $key = $ESC[B ]]; then echo down;  fi
      if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
      # print options by overwriting the last lines
      local idx=0
      for opt; do
        cursor_to $(($startrow + $idx))
        if [ $idx -eq $selected ]; then
          print_selected "$opt"
        else
          print_option "$opt"
        fi
        ((idx++))
      done

        # user key control
        case `key_input` in
          enter) break;;
          up)    ((selected--));
            if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
              if [ $selected -ge $# ]; then selected=0; fi;;
            esac
          done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
  }

# End of function select_option
##____________________________________________________________________//

###################
main "$@"
###################

