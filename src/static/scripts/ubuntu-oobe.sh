#!/usr/bin/bash

print_banner() {
    echo -e "*********************************************************************"
    echo -e "* Rudimentary automated setup script for Debian-based Linux distros *"
    echo -e "* Anh Hoang Nguyen (c) 2025. MIT.                                   *"
    echo -e "* AnhNguyen@aaanh.com                                               *"
    echo -e "*********************************************************************"
}

prompt_continue() {
    echo -e "YOU WILL BE PROMPTED FOR SUPERUSER PASSWORD."
    read -p "Press ENTER to continue..."
}

set_noninteractive() {
    echo -e "Setting script to run non-interactively."
    read -t 3
    export DEBIAN_FRONTEND=noninteractive
}

update_and_upgrade() {
    echo -e "Running: apt update and upgrade"
    read -t 3
    sudo apt update && sudo apt upgrade -y
}

install_packages() {
    echo -e "Running: Install commonly-used packages from apt."
    read -t 3
    sudo apt install -y git zsh net-tools build-essential openssh-server \
        tmux curl
}

setup_zsh() {
    echo -e "Running: Changing default shell to zsh and additional configurations."
    read -t 3
    chsh -s /bin/zsh && \
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 && \
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc" && \
    sed -i 's/robbyrussell/flazz/g' ~/.zshrc
}

install_nvm_golang_rust() {
    echo -e "Running: Install NVM, Golang, and Rust inside new Zsh shell."
    zsh <<'EOF'
        export NVM_DIR="$HOME/.nvm"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
        curl -L https://git.io/vQhTU | bash
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
EOF
}

install_gh_cli() {
    echo -e "Running: Install GitHub CLI."
    read -t 3
    (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
        && sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
        && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && sudo apt update \
        && sudo apt install gh -y
}


install_brew() {
    echo -e "Running: Installing Homebrew."
    read -t 3

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Detect Linuxbrew installation path
    BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
    if [ ! -f "$BREW_PATH" ]; then
        echo "Homebrew installation failed or not found at expected path."
        return 1
    fi

    # Add Homebrew to PATH in .zshrc
    {
        echo ''
        echo '# Homebrew configuration'
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
    } >> ~/.zshrc

    # Apply changes for current shell session
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    echo "Homebrew installed and configured in zsh."
}

install_docker_engine() {
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

install_fantasque_fonts() {
    echo -e "Running: Downloading and installing Fantasque Sans Mono fonts."
    read -t 3

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

    echo -e "Installing fonts to $FONT_TARGET_DIR"
    sudo mkdir -p "$FONT_TARGET_DIR"
    find "$FONT_EXTRACT_DIR" -type f -name "*.$FILETYPE_PATTERN" -exec sudo cp {} "$FONT_TARGET_DIR" \;

    sudo fc-cache -fv

    echo "Fantasque Sans Mono font installation complete."

    # Optional cleanup
    rm -rf "$TMP_DIR"
}


main() {
    print_banner
    prompt_continue
    set_noninteractive
    update_and_upgrade
    install_packages
    setup_zsh
    install_nvm_golang_rust
    install_gh_cli
    install_brew
    install_docker_engine
    echo -e "Setup script completed successfully."
    exit 0
}

main
