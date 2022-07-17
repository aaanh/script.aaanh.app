# .zshrc

## zsh

-   Ubuntu/Debian

```
sudo apt install zsh
```

-   Arch

```
pacman -S zsh
```

-   RHEL and variants

```
yum install zsh
```

-   macOS (installed by default >= Catalina)

> If not, will need `brew` to install.

```
brew install zsh
```

## oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Download my `.zshrc` here <https://linux.hoanganh.dev/_static/.zshrc> and copy it to `$HOME`

Or run this `bash` snippet:

```sh
(curl --user-agent=google-chrome --create-dirs -O --output-dir $HOME/ https://linux.hoanganh.dev/_static/zshrc && mv $HOME/zshrc $HOME/.zshrc && curl --create-dirs -O --output-dir $HOME/ https://raw.githubusercontent.com/marlonrichert/zsh-autocomplete/main/zsh-autocomplete.plugin.zsh && source ~/.zshrc)
```

<details>
<summary>What does my .zshrc contain?</summary>
<ul>
    <li>PATH export to oh-my-zsh</li>
    <li>Set `apple` as oh-my-zsh theme. Alternatively, use `jonathan` or `af-magic`.</li>
    <li>Keybinds for using CTRL + Left/Right for terminal word traversal.</li>
    <li>Plugins: git, zsh-autosuggestions, zsh-autocomplete</li>
</ul>
</details>
