XRDP Server
======================

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