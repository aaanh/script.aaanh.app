# Ubuntu/Debian First Setup

1. **update** repository listing & **upgrade** all existing packages

    ```shell
    sudo apt update && sudo apt upgrade
    ```

2. install commonly-used packages from apt

    ```zsh
    sudo apt install git zsh net-tools build-essential powerline \
            fonts-powerline fonts-firacode vim openssh-server \
            tmux python3 python-is-python3 python3-pip
    ```

3. snap packages

    ```{warning}
    This documentation will no longer use snap packages.
    ```

4. zsh setup

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

5. Use local time (optional, for dual boot)

    ```zsh
    timedatectl set-local-rtc 1 --adjust-system-clock
    ```

6. Set solid black 4K resolution as wallpaper. No bullshit, no patterns.

    ```zsh
    cd /tmp && curl -O "https://unix.hoanganh.tech/_static/img/black-solid-4k.png" && gsettings set org.gnome.desktop.background picture-uri './black-solid-4k.png'
    ```
