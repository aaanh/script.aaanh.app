#!/bin/bash

sudo apt update && sudo apt install zsh

chsh -s /bin/zsh


git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh


cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc


vim ~/.zshrc # change ZSH_THEME="af-magic"


git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1


echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"