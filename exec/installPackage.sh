#!/bin/zsh

# Methods supports

installOhMyZsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

installPower10kBasic() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    rm $HOME/.zshrc
}

installPowerAutoSuggestions() {
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

#Install Methods

installPower10kComplete() {
    installPower10kBasic
    installPowerAutoSuggestions

installTerminalComplete() {
    installOhMyZsh
    installPower10kBasic
    installPowerAutoSuggestions
}

