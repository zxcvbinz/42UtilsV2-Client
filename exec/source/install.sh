#!/bin/zsh

normal=`tput sgr0`
bold=`tput bold`

isInstalled() {
    if [ ! -d $HOME/.42utils ]; then
        return 0
    else 
        return 1
    fi
}

installUtils() {
    if isInstalled; then
        git clone git@github.com:zxcvbinz/42Utils-v2.git $HOME/.42utils
        if ! isInstalled; then
            clear
            echo "\n${bold}42Utils has been installed..\n\n- Start with '42Hub' command\n${normal}"
        fi
    else
        echo "\n${bold}42Utils has been installed..\n\n- Start with '42Hub' command\n${normal}"
    fi
    
}

Warnining() {
    if ! read -q "choice?${bold}This tool overwrite your zsh configuration${normal}, are you sure? y/Y: "; then
        return 1
    else 
        return 0
    fi
}

if Warnining; then
    installUtils
else
    echo "\nAbort."
fi