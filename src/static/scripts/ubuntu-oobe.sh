#!/usr/bin/bash

echo -e "Rudimentary automated setup script for Debian-based Linux distros."
echo -e "Anh Hoang Nguyen (c) 2022. GPLv3."
echo -e "iam@hoanganh.dev"
echo -e "----------------------------"

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."



echo -e "Setting script to run non-interactively."
read -t 3
export DEBIAN_FRONTEND=noninteractive

echo -e "Running: apt update and upgrade"
read -t 3
sudo apt update && sudo apt upgrade -y

echo -e "Running: Install commonly-used packages from apt."
read -t 3
sudo apt install -y git zsh net-tools build-essential powerline \
    fonts-powerline fonts-firacode vim openssh-server \
    tmux python3 python-is-python3 python3-pip curl

echo -e "Uninstall Firefox snap, set up environment and install regular apt package."
sudo snap remove firefox
sudo add-apt-repository ppa:mozillateam/ppa
echo 'Package: *                        
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
sudo apt install -y firefox

echo -e "Running: Changing default shell to zsh and additional configurations."
read -t 3
chsh -s /bin/zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
sed -i 's/robbyrussell/flazz/g' ~/.zshrc

echo -e "Setup script completed successfully."
exit 0