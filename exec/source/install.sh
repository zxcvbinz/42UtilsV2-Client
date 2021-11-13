#!/bin/zsh

normal=`tput sgr0`
bold=`tput bold`
orange=`tput setaf 208`
green=`tput setaf 46`
magenta=`tput setaf 9`
red=`tput setaf 196`
WARN="${bold}[${orange}WARNING${normal}${bold}] "
HINT="${bold}[${magenta}HINT${normal}${bold}] "
COMPLETE="${bold}[${green}COMPLETE${normal}${bold}] "
ERROR="${bold}[${red}ERROR${normal}${bold}] "

SECURITY_MODE=1

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
    fi
    echo "export PATH=\"\$HOME/.42Utils/exec/:\$PATH\"" >> ~/.zshrc
    chmod 755 $HOME/.42utils/exec/42Hub
}

installUtils() {
    if isInstalled; then
        git clone https://github.com/zxcvbinz/42Utils-v2.git $HOME/.42utils
        installOhMyZsh
        if ! isInstalled; then
            echo "${WARN}${COMPLETE}42Utils has been installed..\n\n${HINT}- Reload your session with 'source ~/.zshrc'\n\n${HINT}- Start with '42Hub' command\n${normal}"
        fi
    else
        echo "${WARN}42Utils has been installed..\n\n${HINT}- Reload your session with 'source ~/.zshrc'\n\n${HINT}- Start with '42Hub' command\n${normal}"
    fi
}

Warning() {
    if isInstalled; then
        if read -q "choice?${WARN}This tool overwrite your zsh configuration${normal}, are you sure? y/Y: "; then
            echo "\n"
            return 0
        else 
            echo "\n"
            return 1
        fi
        return 0
    fi
}

checkOS() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo "${ERROR}You not run macOS system."
        echo "${WARN}Disable 'SECURITY_MODE':14 for install untested version."
        return 1
    fi
    return 0
}

if Warning; then
    if [[ "$SECURITY_MODE" == 1 ]]; then
        if checkOS; then
            installUtils
            exec zsh
        fi
    else
        installUtils
        exec zsh
    fi
else
    echo "Abort."
fi
