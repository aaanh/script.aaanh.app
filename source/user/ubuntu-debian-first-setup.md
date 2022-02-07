# Ubuntu/Debian First Setup

1. **update** repository listing & **upgrade** all existing packages

    ```shell
    sudo apt update && sudo apt upgrade
    ```

1. install commonly-used packages from `apt`

    ```zsh
    sudo apt install git zsh net-tools build-essential powerline \
            fonts-powerline fonts-firacode vim openssh-server \
            tmux python3 python-is-python3 python3-pip curl
    ```

1. additional optional packages from `apt`

    ```zsh
    sudo apt install gnome-tweaks grub-customizer nodejs npm
    ```

1. juiced up `vim`

    ```zsh
    git clone https://github.com/aaanh/vimrc ~/.vim_runtime && cd ~/.vim_runtime && ./install_awesome_vimrc.sh
    ```

    > Forked from [https://github.com/amix/vimrc](https://github.com/amix/vimrc). Edit personal configs in `~/.vim_runtime/my_configs.vim`.

1. snap packages

    ```{warning}
    This documentation will no longer use snap packages.
    ```

1. zsh setup

    \# Change shell

    ```zsh
    chsh -s /bin/zsh
    ```

    \# Clone oh-my-zsh configs

    ```zsh
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    ```

    \# Copy the config template into .zshrc

    ```zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    ```

    \# Change to the good theme

    ```zsh
    vim ~/.zshrc # change ZSH_THEME="af-magic"
    ```

    \# Add syntax highlighting

    ```zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
    ```

    \# Source highlighting plugins on start

    ```zsh
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
    ```

1. Use local time (optional, for dual boot)

    ```zsh
    timedatectl set-local-rtc 1 --adjust-system-clock
    ```

1. additional applications you might need

    - Visual Studio Code: https://code.visualstudio.com/download
    - Discord: https://discord.com/download
    - Anaconda: https://www.anaconda.com/products/individual
    - Zoom: https://zoom.us/download
    - Slack (snap or rpm): https://slack.com/downloads/linux

1. Install Github CLI for Linux-based distros

    <https://github.com/cli/cli/blob/trunk/docs/install_linux.md>

    Extracted installation command for Debian for convenience:

    ```zsh
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    ```

    - Then, authorization Github CLI using `gh auth login`

1. Set solid black 4K resolution as wallpaper. No bullshit, no patterns.

    ```{note}
    This script is deprecated as of Ubuntu 21.04+. Using it would just weirdly set a blue background (wtf?) To use the background, download it and set it via the graphical gnome settings.
    ```

    ```zsh
    cd /tmp && curl -O "https://unix.hoanganh.tech/_static/img/black-solid-4k.png" && gsettings set org.gnome.desktop.background picture-uri './black-solid-4k.png'
    ```

    **Script for Ubuntu 21.10**

    ```zsh
    curl -O "https://unix.hoanganh.tech/_static/img/black-solid-4k.png"
    ```
