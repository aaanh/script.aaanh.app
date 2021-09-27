Ubuntu/Debian First Setup
=================================

1. **update** repository listing & **upgrade** all existing packages

    ```shell
    sudo apt update && sudo apt upgrade
    ```

2. install commonly-used packages from apt

    ```zsh
    sudo apt install git zsh net-tools build-essential powerline \
            fonts-powerline fonts-firacode vim openssh-server \
            tmux gnome-tweak-tool grub-customizer
    ```

3. snap packages

    ```
    sudo snap install --classic code
    ```
    ```
    sudo snap install --classic zoom-client
    ```
    ```
    sudo snap install --classic discord
    ```
    ```
    sudo snap install --classic slack
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
    gsettings set org.gnome.desktop.background picture-uri "https://linux.hoanganh.tech/_static/img/black-solid-4k.png"
    ```
