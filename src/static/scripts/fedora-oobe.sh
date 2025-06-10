#!/usr/bin/env bash
set -e

print_banner() {
    echo -e "*******************************************************************"
    echo -e "* Rudimentary automated setup script for Fedora/RHEL/CentOS Linux.*"
    echo -e "* Anh Hoang Nguyen (c) 2025. MIT License                          *"
    echo -e "* AnhNguyen@aaanh.com                                             *"
    echo -e "*******************************************************************"
}

prompt_continue() {
    echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
    read -p "Press ENTER to continue..."
}

dnf_update() {
    echo -e "Running: dnf update"
    read -t 2
    sudo dnf -y update
}

install_packages() {
    echo -e "Running: Install commonly-used packages from dnf."
    read -t 2
    sudo dnf install -y wget git neovim tmux unzip curl
}

setup_zsh() {
    echo -e "Running: Changing default shell to zsh, install oh-my-zsh and additional configurations."
    read -t 2
    sudo usermod -s /usr/bin/zsh "$(whoami)"
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
    sed -i 's/robbyrussell/flazz/g' ~/.zshrc
}

install_nvm_golang_rust() {
    echo -e "Running: Installing nvm, golang, rust"
    read -t 2
    echo -e "Node Version Manager (nvm)"
    read -t 2
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    echo -e "Golang (using 3rd party convenient script)"
    read -t 2
    curl -L https://git.io/vQhTU | bash

    echo -e "Rust (using rustup)"
    read -t 2
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

install_gh_cli() {
    echo -e "Running: Installing gh CLI"
    read -t 2
    sudo dnf install -y dnf5-plugins
    sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
    sudo dnf install -y gh --repo gh-cli
}

install_brew() {
    echo -e "Running: Installing homebrew package manager"
    read -t 2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_fantasque_fonts() {
    echo -e "Running: Installing Powerline font Fantasque Sans Mono"
    read -t 2

    TMP_DIR="$HOME/.tmp-font-install"
    FONT_ZIP_URL="https://script.aaanh.app/static/fonts/FantasqueSansMono.zip"
    FONT_ZIP_NAME="FantasqueSansMono.zip"
    FONT_EXTRACT_DIR="$TMP_DIR/fantasque-mono"
    FONT_TARGET_DIR="/usr/share/fonts/custom"
    FILETYPE_PATTERN="ttf"

    mkdir -p "$TMP_DIR"
    cd "$TMP_DIR" || return 1

    curl -O "$FONT_ZIP_URL"
    mkdir -p "$FONT_EXTRACT_DIR"
    unzip -q "$FONT_ZIP_NAME" -d "$FONT_EXTRACT_DIR"

    curl -O https://gist.githubusercontent.com/aaanh/2477c68314a144ee76de6858a57bed36/raw/fcd6a2dbbdc034f5f22c99c8085a1d6e575d293d/install-fonts-fedora.sh
    sudo bash ./install-fonts-fedora.sh "$FONT_EXTRACT_DIR" "$FONT_TARGET_DIR" "$FILETYPE_PATTERN"

    rm -rf "$TMP_DIR"
}

install_docker() {
    echo -e "Running: Installing Docker Engine only"
    read -t 2
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable --now docker

    sudo groupadd docker || true
    sudo usermod -aG docker "$USER"

    echo -e "You need to log out and log back in for the Docker group changes to take effect."
}

main() {
    print_banner
    prompt_continue
    dnf_update
    install_packages
    setup_zsh
    install_nvm_golang_rust
    install_gh_cli
    install_brew
    install_fantasque_fonts
    install_docker
    echo -e "Setup script completed successfully."
}

main
