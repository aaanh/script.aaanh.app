# XRDP Server

# Installation

1. Install a desktop environment

> This is just an example with `gnome-desktop`. Install whichever DE you prefer. E.g. xfce4, mate, kde, etc.

    ```sh
    sudo apt install gnome-desktop
    ```

2. Install XRDP server

    ```sh
    sudo apt install
    ```

# Configuration

1. Reconfigure the desktop environment

    ```zsh
    sudo dpkg-reconfigure $(desktop-environment-name)
    ```

2. Change default xrdp session

    ```zsh
    sudo update-alternatives --config x-session-manager
    ```

3. Change default xrdp session to budgie by editing the xrdp config file
    ```zsh
    sudoedit /etc/xrdp/startwm.sh
    ```
