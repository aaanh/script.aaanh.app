#!/usr/bin/env bash

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# Error handler
error_exit() {
    log_error "$1"
    exit "${2:-1}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running as root
check_not_root() {
    if [ "$EUID" -eq 0 ]; then
        error_exit "This script should not be run as root. It will use sudo when needed."
    fi
}

# Check sudo access
check_sudo() {
    if ! sudo -n true 2>/dev/null; then
        log_warn "Sudo access required. You may be prompted for your password."
        sudo -v || error_exit "Failed to obtain sudo access"
    fi
}

# Check if already installed
is_installed() {
    dpkg -l | grep -q "^ii  $1 " 2>/dev/null
}

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
    log_info "Setting script to run non-interactively."
    export DEBIAN_FRONTEND=noninteractive
}

update_and_upgrade() {
    log_info "Running: apt update and upgrade"
    sudo apt update || error_exit "Failed to update apt"
    sudo apt upgrade -y || error_exit "Failed to upgrade packages"
    log_info "System packages updated successfully"
}

install_packages() {
    log_info "Installing commonly-used packages from apt."
    local packages=(
        git
        zsh
        net-tools
        build-essential
        openssh-server
        tmux
        curl
        wget
        unzip
        ca-certificates
    )
    
    local to_install=()
    for pkg in "${packages[@]}"; do
        if ! is_installed "$pkg"; then
            to_install+=("$pkg")
        fi
    done
    
    if [ ${#to_install[@]} -eq 0 ]; then
        log_info "All required packages are already installed"
        return 0
    fi
    
    sudo apt install -y "${to_install[@]}" || error_exit "Failed to install packages"
    log_info "Packages installed successfully"
}

setup_zsh() {
    log_info "Setting up zsh and additional configurations."
    
    # Check if zsh is already the default shell
    if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
        log_info "zsh is already the default shell"
    else
        chsh -s "$(command -v zsh)" || error_exit "Failed to change default shell to zsh"
        log_info "Default shell changed to zsh"
    fi
    
    # Install oh-my-zsh if not already installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" || \
            error_exit "Failed to clone oh-my-zsh"
        log_info "oh-my-zsh installed"
    else
        log_info "oh-my-zsh already installed"
    fi
    
    # Setup zshrc if it doesn't exist or is empty
    if [ ! -f "$HOME/.zshrc" ] || [ ! -s "$HOME/.zshrc" ]; then
        cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc" || \
            error_exit "Failed to create .zshrc"
    fi
    
    # Install zsh-syntax-highlighting if not already installed
    if [ ! -d "$HOME/.zsh-syntax-highlighting" ]; then
        git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
            "$HOME/.zsh-syntax-highlighting" || error_exit "Failed to clone zsh-syntax-highlighting"
        
        if ! grep -q "zsh-syntax-highlighting" "$HOME/.zshrc"; then
            echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
        fi
        log_info "zsh-syntax-highlighting installed"
    else
        log_info "zsh-syntax-highlighting already installed"
    fi
    
    # Update theme if needed
    if grep -q 'ZSH_THEME="robbyrussell"' "$HOME/.zshrc"; then
        sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="flazz"/' "$HOME/.zshrc"
        log_info "zsh theme updated to flazz"
    fi
    
    log_info "zsh setup completed successfully"
}

install_nvm_golang_rust() {
    log_info "Installing NVM, Golang, and Rust."
    
    # Install NVM
    if [ ! -d "$HOME/.nvm" ]; then
        export NVM_DIR="$HOME/.nvm"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash || \
            error_exit "Failed to install NVM"
        log_info "NVM installed"
    else
        log_info "NVM already installed"
    fi
    
    # Install Go
    if ! command_exists go; then
        curl -L https://git.io/vQhTU | bash || error_exit "Failed to install Go"
        log_info "Go installed"
    else
        log_info "Go already installed"
    fi
    
    # Install Rust
    if ! command_exists rustc; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || \
            error_exit "Failed to install Rust"
        log_info "Rust installed"
    else
        log_info "Rust already installed"
    fi
}

install_gh_cli() {
    log_info "Installing GitHub CLI."
    
    if command_exists gh; then
        log_info "GitHub CLI already installed"
        return 0
    fi
    
    # Ensure wget is installed
    if ! command_exists wget; then
        sudo apt update && sudo apt install -y wget || error_exit "Failed to install wget"
    fi
    
    sudo mkdir -p -m 755 /etc/apt/keyrings || error_exit "Failed to create keyrings directory"
    
    local keyring_file
    keyring_file=$(mktemp) || error_exit "Failed to create temporary file"
    trap "rm -f $keyring_file" EXIT
    
    wget -nv -O "$keyring_file" https://cli.github.com/packages/githubcli-archive-keyring.gpg || \
        error_exit "Failed to download GitHub CLI GPG key"
    
    sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg < "$keyring_file" > /dev/null || \
        error_exit "Failed to install GPG key"
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
        sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null || \
        error_exit "Failed to add GitHub CLI repository"
    
    sudo apt update || error_exit "Failed to update apt after adding GitHub CLI repository"
    sudo apt install -y gh || error_exit "Failed to install GitHub CLI"
    
    log_info "GitHub CLI installed successfully"
}

install_brew() {
    log_info "Installing Homebrew."
    
    if command_exists brew; then
        log_info "Homebrew already installed"
        return 0
    fi
    
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || \
        error_exit "Failed to install Homebrew"
    
    # Detect Linuxbrew installation path
    local brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
    if [ ! -f "$brew_path" ]; then
        brew_path="$HOME/.linuxbrew/bin/brew"
        if [ ! -f "$brew_path" ]; then
            error_exit "Homebrew installation failed or not found at expected path"
        fi
    fi
    
    # Add Homebrew to PATH in .zshrc if not already present
    if ! grep -q "brew shellenv" "$HOME/.zshrc" 2>/dev/null; then
        {
            echo ''
            echo '# Homebrew configuration'
            echo "eval \"\$($(dirname "$brew_path")/brew shellenv)\""
        } >> "$HOME/.zshrc"
    fi
    
    # Apply changes for current shell session
    eval "$($(dirname "$brew_path")/brew shellenv)"
    
    log_info "Homebrew installed and configured in zsh"
}

install_docker_engine() {
    log_info "Installing Docker Engine."
    
    if command_exists docker; then
        log_info "Docker already installed"
        return 0
    fi
    
    # Add Docker's official GPG key
    sudo apt-get update || error_exit "Failed to update apt"
    sudo apt-get install -y ca-certificates curl || error_exit "Failed to install prerequisites"
    
    sudo install -m 0755 -d /etc/apt/keyrings || error_exit "Failed to create keyrings directory"
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc || \
        error_exit "Failed to download Docker GPG key"
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Add the repository to Apt sources
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || \
        error_exit "Failed to add Docker repository"
    
    sudo apt-get update || error_exit "Failed to update apt after adding Docker repository"
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || \
        error_exit "Failed to install Docker"
    
    # Add current user to docker group
    sudo usermod -aG docker "$USER" || log_warn "Failed to add user to docker group (you may need to log out and back in)"
    
    log_info "Docker Engine installed successfully"
    log_warn "You may need to log out and back in for docker group changes to take effect"
}

install_fantasque_fonts() {
    log_info "Downloading and installing Fantasque Sans Mono fonts."
    
    local tmp_dir="$HOME/.tmp-font-install"
    local font_zip_url="https://script.aaanh.app/static/fonts/FantasqueSansMono.zip"
    local font_zip_name="FantasqueSansMono.zip"
    local font_extract_dir="$tmp_dir/fantasque-mono"
    local font_target_dir="/usr/share/fonts/custom"
    local filetype_pattern="ttf"
    
    mkdir -p "$tmp_dir" || error_exit "Failed to create temporary directory"
    cd "$tmp_dir" || error_exit "Failed to change to temporary directory"
    
    # Cleanup function
    cleanup_fonts() {
        cd "$HOME" || true
        rm -rf "$tmp_dir" || true
    }
    trap cleanup_fonts EXIT
    
    curl -f -O "$font_zip_url" || error_exit "Failed to download font archive"
    mkdir -p "$font_extract_dir" || error_exit "Failed to create extract directory"
    unzip -q "$font_zip_name" -d "$font_extract_dir" || error_exit "Failed to extract font archive"
    
    log_info "Installing fonts to $font_target_dir"
    sudo mkdir -p "$font_target_dir" || error_exit "Failed to create font target directory"
    find "$font_extract_dir" -type f -name "*.$filetype_pattern" -exec sudo cp {} "$font_target_dir" \; || \
        error_exit "Failed to copy fonts"
    
    sudo fc-cache -fv || error_exit "Failed to update font cache"
    
    log_info "Fantasque Sans Mono font installation complete"
}

main() {
    print_banner
    check_not_root
    check_sudo
    prompt_continue
    set_noninteractive
    
    # Keep sudo alive
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &
    
    update_and_upgrade
    install_packages
    setup_zsh
    install_nvm_golang_rust
    install_gh_cli
    install_brew
    install_docker_engine
    install_fantasque_fonts
    
    log_info "Setup script completed successfully!"
    log_warn "Please log out and back in for all changes to take effect (especially zsh and docker group)"
    exit 0
}

main
