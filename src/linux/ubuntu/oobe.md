# Ubuntu Out-of-the-Box Experience

## Convenience Script

Static file: [/static/scripts/ubuntu-oobe.sh](/static/scripts/ubuntu-oobe.sh)

```bash
sudo apt install -y curl && curl -fSsL https://script.aaanh.app/static/scripts/ubuntu-oobe.sh | bash
```

If `curl` is not installed, install it with `sudo apt install curl`.

**Note:** This script should not be run as root. It will use `sudo` when needed and will prompt for your password.

<details>
    <summary>What this script does?</summary>
    <ul>
        <li>Updates and upgrades system packages via apt</li>
        <li>Installs essential packages: git, zsh, net-tools, build-essential, openssh-server, tmux, curl, wget, unzip, ca-certificates</li>
        <li>Sets up and configures zsh with oh-my-zsh, zsh-syntax-highlighting, and flazz theme</li>
        <li>Installs development tools: NVM (Node Version Manager), Go, and Rust</li>
        <li>Installs GitHub CLI (gh)</li>
        <li>Installs Homebrew (Linuxbrew)</li>
        <li>Installs Docker Engine and adds user to docker group</li>
        <li>Downloads and installs Fantasque Sans Mono fonts</li>
    </ul>
    <p><strong>Important:</strong> After running the script, you should log out and back in for all changes to take effect (especially zsh shell and docker group membership).</p>
</details>

## Dev Tools

```bash
sudo apt install -y curl && curl -fSsL https://script.aaanh.app/static/scripts/ubuntu-dev-tools.sh | bash
```

## Manual

1. Update and upgrade apt
   ```sh
   sudo apt update && sudo apt upgrade -y
   ```
1. Install commonly-used packages
   ```sh
   sudo apt install -y git zsh net-tools build-essential openssh-server \
     tmux curl wget unzip ca-certificates
   ```
1. Additional optional desktop packages
   ```sh
   sudo apt install gnome-tweaks grub-customizer nodejs npm
   ```
1. Install and power up `vim`
   ```sh
   git clone https://github.com/aaanh/vimrc ~/.vim_runtime && cd ~/.vim_runtime && ./install_awesome_vimrc.sh
   ```
1. Use local time (optional, for dual boot with Windows)
   ```sh
   timedatectl set-local-rtc 1 --adjust-system-clock
   ```
1. Setup zsh with oh-my-zsh and plugins
   ```sh
   chsh -s $(which zsh)
   git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
   cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting --depth 1
   echo "source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
   sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="flazz"/' ~/.zshrc
   ```
1. Install NVM, Go, and Rust
   ```sh
   # NVM
   export NVM_DIR="$HOME/.nvm"
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
   
   # Go
   curl -L https://git.io/vQhTU | bash
   
   # Rust
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
   ```
1. GitHub CLI
   ```sh
   sudo mkdir -p -m 755 /etc/apt/keyrings
   wget -nv -O- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
   sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
   sudo apt update
   sudo apt install -y gh
   ```
   After installation, login with `gh auth login`
1. Homebrew (Linuxbrew)
   ```sh
   NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
   echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
   ```
1. Docker Engine
   ```sh
   sudo apt-get update
   sudo apt-get install -y ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   sudo usermod -aG docker $USER
   ```
   **Note:** Log out and back in for docker group changes to take effect.
1. Fantasque Sans Mono fonts
   ```sh
   TMP_DIR="$HOME/.tmp-font-install"
   FONT_ZIP_URL="https://script.aaanh.app/static/fonts/FantasqueSansMono.zip"
   mkdir -p "$TMP_DIR"
   cd "$TMP_DIR"
   curl -O "$FONT_ZIP_URL"
   unzip -q FantasqueSansMono.zip -d fantasque-mono
   sudo mkdir -p /usr/share/fonts/custom
   find fantasque-mono -type f -name "*.ttf" -exec sudo cp {} /usr/share/fonts/custom \;
   sudo fc-cache -fv
   rm -rf "$TMP_DIR"
   ```
1. Additional user applications

   1. Visual Studio Code: <https://code.visualstudio.com/download>

   1. Discord: <https://discord.com/download>

   1. Anaconda: <https://www.anaconda.com/products/individual>

   1. Zoom: <https://zoom.us/download>

   1. Slack (snap or rpm): <https://slack.com/downloads/linux>

1. Solid black 4K resolution wallpaper 👌
   ```sh
   curl -o ~/Pictures/black.png "https://script.aaanh.app/static/images/black.png"
   ```
