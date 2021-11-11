#!/bin/zsh

normal=`tput sgr0`
bold=`tput bold`
orange=`tput setaf 172`
green=`tput setaf 2`
magenta=`tput setaf 9`
WARN="${bold}[${orange}WARNING${normal}${bold}] "
HINT="${bold}[${green}HINT${normal}${bold}] "
COMPLETE="${bold}[${magenta}COMPLETE${normal}${bold}] "
isInstalled() {
    if [ ! -d $HOME/.42utils ]; then
        return 0
    else 
        return 1
    fi
}

installOhMyZsh() {
    if [ ! -d $HOME/.oh-my-zsh ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        echo "${WARN}Installed oh-my-zsh"
    fi
    echo "export PATH=\"\$HOME/.42Utils/exec/:\$PATH\"" >> ~/.zshrc
    export PATH=$HOME/.42utils/exec:$PATH
}

installUtils() {
    if isInstalled; then
        git clone https://github.com/zxcvbinz/42Utils-v2.git $HOME/.42utils
        installOhMyZsh
        if ! isInstalled; then
            echo "${WARN}${COMPLETE}42Utils has been installed..\n\n${HINT}- Start with '42Hub' command\n${normal}"
        fi
    else
        echo "${WARN}42Utils has been installed..\n\n${HINT}- Start with '42Hub' command\n${normal}"
    fi
}

Warning() {
    if read -q "choice?${WARN}This tool overwrite your zsh configuration${normal}, are you sure? y/Y: "; then
        echo "\n"
        return 0
    else 
        echo "\n"
        return 1
    fi
}

if Warning; then
    installUtils
else
    echo "Abort."
fi