# .zshrc

`zsh` can be installed via any popular package manager, like `apt`, `pacman`, `brew`, `yum`, etc.

> `zsh` is installed and enabled on MacOS by default since Catalina.

`oh-my-zsh` can be installed via:

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Download my `.zshrc` here <https://linux.hoanganh.dev/_static/.zshrc> and copy it to `$HOME`

Or run this `bash` snippet:

```sh
(curl --create-dirs -O --output-dir $HOME/ https://linux.hoanganh.dev/_static/.zshrc && curl --create-dirs -O --output-dir $HOME/ https://raw.githubusercontent.com/marlonrichert/zsh-autocomplete/main/zsh-autocomplete.plugin.zsh && source ~/.zshrc)
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

# .vimrc

```sh
(git clone https://github.com/aaanh/vimrc ~/.vim_runtime && cd ~/.vim_runtime && ./install_awesome_vimrc.sh)
```

# .gdbinit

The tried and tested debugger.

```sh
curl --create-dirs -O --output-dir $HOME/ https://raw.githubusercontent.com/gdbinit/Gdbinit/master/gdbinit && mv ~/gdbinit ~/.gdbinit
```
