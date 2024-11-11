#!/usr/bin/bash

echo -e "*******************************************************************"
echo -e "* Rudimentary automated setup script for Fedora/RHEL/CentOS Linux.*"
echo -e "* Anh Hoang Nguyen (c) 2024. MIT.                                 *"
echo -e "* AnhNguyen@aaanh.com                                             *"
echo -e "*******************************************************************"

echo -e "Now loading script..."
read -t 3

echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
read -p "Press ENTER to continue..."

# ---------------------------------

echo -e "Running: dnf update"
read -t 3
sudo dnf -y update

# ---------------------------------

echo -e "Running: Install commonly-used packages from dnf."
read -t 3
sudo dnf install -y zsh wget git neovim tmux

# ---------------------------------

echo -e "Running: Changing default shell to zsh, install oh-my-zsh and additional configurations."
read -t 3

sudo usermod -s /usr/bin/zsh "$(whoami)"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
sed -i 's/robbyrussell/flazz/g' ~/.zshrc

# ---------------------------------

echo -e "Running: Installing nvm, golang, rust"
read -t 3

echo -e "Node Version Manager (nvm)"
read -t 2
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

echo -e "Golang (using 3rd party convenient script)"
read -t 2
curl -L https://git.io/vQhTU | bash

echo -e "Rust (using rustup)"
read -t 2
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# ---------------------------------

echo -e "Running: Installing gh CLI"
read -t 3

sudo dnf install -y dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh --repo gh-cli

# ---------------------------------

echo -e "Running: Installing homebrew package manager"
read -t 3

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ---------------------------------

echo -e "Running: Installing Visual Studio Code"
read -t 3

sudo rpm --import https://packages.microsoft.com/keys/microsoft.ascecho -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install -y code # or code-insiders

# ---------------------------------

echo -e "Running: Installing Powerline font Fantasque Sans Mono"
read -t 3

curl -O https://script.aaanh.app/static/fonts/FantasqueSansMono.zip
mkdir ./fantasque-mono
unzip FantasqueSansMono.zip -d ./fantasque-mono

curl -O https://gist.githubusercontent.com/aaanh/2477c68314a144ee76de6858a57bed36/raw/fcd6a2dbbdc034f5f22c99c8085a1d6e575d293d/install-fonts-fedora.sh
sudo bash ./install-fonts-fedora.sh ./fantasque-mono /usr/share/fonts/custom ttf

# ---------------------------------

echo -e "Running: Installing Docker Engine only"
read -t 3

sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

sudo groupadd docker
sudo usermod -aG docker $USER

echo -e "You need to log out and log back in for the Docker group changes to take effect."

# ---------------------------------

echo -e "Setup script completed successfully."
exit 0