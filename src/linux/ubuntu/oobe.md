# Ubuntu Out-of-the-Box Experience

## Convenience Script

Static file: [/static/scripts/ubuntu-oobe.sh](/static/scripts/ubuntu-oobe.sh)

```bash
(curl -fSsl https://scripts.aaanh.com/static/scripts/ubuntu-oobe.sh && bash ubuntu-oobe.sh && rm ubuntu-oobe.sh)
```

If `curl` is not installed, install it with `sudo apt install curl`.

<details>
    <summary>What this script does?</summary>
    <ul>
        <li>Use apt to update and upgrade</li>
        <li>Install packages: git, zsh, net-tools, build-essential, powerline, fonts-powerline, fonts-firacode, vim, openssh-server, tmux, python3, python-is-python3 python3-pip.</li>
        <li>Set up and configure zsh, oh-my-zsh, zsh-highlighting, zsh theme.</li>
    </ul>
</details>

## Manual

1. Update and upgrade apt
    ```sh
    sudo apt update && sudo apt upgrade
    ```
2. Install commonly-used packages
    ```sh
    sudo apt install git zsh net-tools build-essential powerline \
      fonts-powerline fonts-firacode vim openssh-server \
      tmux python3 python-is-python3 python3-pip curl
    ```
3. Additional optional desktop packages
    ```sh
    sudo apt install gnome-tweaks grub-customizer nodejs npm
    ```
4. Install and power up `vim`
    ```sh
    git clone https://github.com/aaanh/vimrc ~/.vim_runtime && cd ~/.vim_runtime && ./install_awesome_vimrc.sh
    ```
5. Setup `zsh` shell
    ```sh
    (curl https://linux.hoanganh.tech/_static/zsh-setup.sh | sudo -E bash -)
    ```
6. Use local time (optional, for dual boot with Windows)
    ```sh
    timedatectl set-local-rtc 1 --adjust-system-clock
    ```
7. Github CLI
    ```sh
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    ```
    After installation, login with `gh auth login`
8. Additional user applications
   1. Visual Studio Code: <https://code.visualstudio.com/download>

   2.  Discord: <https://discord.com/download>

   3.  Anaconda: <https://www.anaconda.com/products/individual>

   4.  Zoom: <https://zoom.us/download>

   5.  Slack (snap or rpm): <https://slack.com/downloads/linux>
9.  Solid black 4K resolution wallpaper 👌
    ```sh
    wget --user-agent="chrome" "https://scripts.aaanh.com/static/images/black-solid-4k.png" -O ~/
    ```
