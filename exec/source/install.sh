#!/bin/zsh

programs=("Docker42Helper" "SetWorkSpace" "42utils-command-BETA")
# ("test2" "test1" "test3")
bold=`tput bold`
underline=`tput smul`
black=`tput setaf 0`
red=`tput setaf 1`
yellow=`tput setaf 3`
green=`tput setaf 2`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`
bell=`tput bel`

WHITE='\033[1;37m'
DARKGRAY='\033[1;30m';
GREEN='\033[0;32m';
LIGHTPURPLE='\033[1;35m';
CYAN='\033[0;36m';
RED='\033[0;31m';
LIGHTPURPLE='\033[1;35m'
ORANGE='\033[0;33m'

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

function select_opt {
    select_option "$@" 1>&2
    local result=$?
    echo $result
    return $result
}

function Choose(){
	echo -e "${bell}${underline}${bold}${yellow}Seleziona un programma\n${reset}"
	case `select_opt "${programs[@]}"` in
	*)
	Choose=${programs[$?]}
	;;
	esac
	export Choose;
}

Choose programs

#installUtils() {
#    git clone https://github.com/zxcvbinz/42Utils-v2.git $HOME/.42utils
#}
#
#installUtils