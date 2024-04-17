#!/bin/sh

ZSHRC_PATH="$HOME/.zshrc"

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1

# Powerlevel10k Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' $ZSHRC_PATH

# Zsh Plugins
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i '/plugins=(/,/)/c\plugins=(\n  git\n  zsh-completions\n  zsh-autosuggestions\n  zsh-syntax-highlighting\n)' $ZSHRC_PATH

# Powerlevel10k Config
wget https://raw.githubusercontent.com/OnCloud125252/Oh-My-Zsh-Setup/main/.p10k.zsh -O $HOME/.p10k.zsh
wget https://raw.githubusercontent.com/OnCloud125252/Oh-My-Zsh-Setup/main/.p10k-warp.zsh -O $HOME/.p10k-warp.zsh
sed -i 's/\[\[ ! -f ~\/.p10k\.zsh \]\] || source ~\/.p10k\.zsh/if \[\[ $(printenv | grep WARP) \]\];\nthen\n\t[[ ! -f ~\/.p10k-warp.zsh \]\] || source ~\/.p10k-warp.zsh\nelse\n\t[[ ! -f ~\/.p10k.zsh \]\] || source ~\/.p10k.zsh\nfi/' $ZSHRC_PATH

source $ZSHRC_PATH
