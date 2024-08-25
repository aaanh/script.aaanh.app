# Manjaro OOBE

## Convenience Script

```sh
sudo pacman -Sy curl && curl -O https://script.aaanh.app/static/scripts/manjaro-oobe.sh | bash ./manjaro-oobe.sh
```

## Manual

## Manual steps

1. Update and choose optimal mirror for pac(kage)man(ager)

    ```zsh
    sudo pacman -Syyu
    ```

2. Install build tools for AUR

    ```zsh
    sudo pacman -Sy base-devel git
    ```

3. Install commonly-used packages

    ```
    sudo pacman -Sy ttf-fira-code ibus-unikey zsh discord
    ```

4. Install packages from AUR

- Browse AUR here <https://aur.archlinux.org/>

- Clone repository

    ```zsh
    git clone <repository>
    ```

    ```zsh
    cd <repository>
    ```

- Compile, install with dev dependencies, remove or clean up build and dev dependencies.

    ```zsh
    makepkg -sri
    ```

5. Clone AUR repos and Install Script

    ```sh
    cd ~/Downloads\
    (git clone https://aur.archlinux.org/google-chrome.git && cd google-chrome && makepkg -sri ./google-chrome/)\
    (git clone https://aur.archlinux.org/visual-studio-code-bin.git && cd visual-studio-code-bin && makepkg -sri ./visual-studio-code-bin/)
    ```