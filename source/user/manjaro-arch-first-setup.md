# Manjaro/Arch First Setup

## This is a WIP

1. Update and choose optimal mirror for pac(kage)man(ager)

    ```zsh
    sudo pacman -Syyu
    ```

2. Install build tools for AUR

    ```zsh
    sudo pacman -Sy base-devel git
    ```

3. Install commonly-used packages

    From `pacman`:

    ```zsh

    ```

    From `AUR`:

    ```zsh
    git clone <repository>
    ```

    ```zsh
    cd <repository>
    ```

    Compile, install with dev dependencies, remove or clean up build and dev dependencies.

    ```zsh
    makepkg -sri
    ```
