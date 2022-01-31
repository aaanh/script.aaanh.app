# Manjaro First Setup

1. Update and choose optimal mirror for pac(kage)man(ager)

    ```zsh
    sudo pacman -Syyu
    ```

2. Install build tools for AUR

    ```zsh
    sudo pacman -Sy base-devel git
    ```

3. Install packages from AUR

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
