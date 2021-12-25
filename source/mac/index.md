# Mac for Development Setup

Bonus: Because Mac is getting too good and Mac shares the Unix core...

Since Mac uses the `zsh` terminal shell by default, some scripts for Ubuntu can be re-used: from getting oh-my-zsh config to sourcing the highlighting plugin. </user/ubuntu-debian-first-setup.html>

-   Install the xcode cli.

    ```{note}
    This also install git. If you try to use git first, it will prompt you to install the cli tool.
    ```

    ```zsh
    xcode-select --install
    ```

-   Install brew (stolen from <https://brew.sh>)

    ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

-   Install `pip` for pre-installed `python3`

    ```zsh
    python3 -m ensurepip --install
    ```

-   Install brew packages

    ```zsh
    brew install npm nodejs gh
    ```

-   Set up `gh` for GitHub operations

    ```zsh
    gh auth login
    ```

    Select Personal > HTTPS

## For Apple Silicon

-   Install Rosetta 2

    ```zsh
    sudo softwareupdate --install-rosetta --agree-to-license
    ```

## Optional stuff

-   Anaconda <https://www.anaconda.com/products/individual>
-   vscode <https://code.visualstudio.com/download>
-   Discord <https://discord.com/api/download?platform=osx>
