# macOS Out-of-the-Box Experience

## Convenience Script

Static file: [/static/scripts/macbook-oobe.sh](/static/scripts/macbook-oobe.sh)

```bash
(curl -fSsl https://scripts.aaanh.com/static/scripts/macbook-oobe.sh >> macbok-oobe.sh && chmod 700 macbook-oobe.sh && bash macbook-oobe.sh && rm macbook-oobe.sh)
```

## Manual

### Set up `homebrew`

> This also installs xcode command line tools

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Set up `oh-my-zsh`

1. Install via official script

   ```sh
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. Configure theme

   ```sh
   sed -i 's/robbyrussell/apple/g' ~/.zshrc
   ```

3. Set up `zsh-syntax-highlighting`

   ```sh
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
   echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
   ```

### Install VS Code

1. Download via `curl`

   ```sh
   curl -L "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal" -o ~/Downloads/vscode.zip
   ```

2. Extract

   ```sh
   unzip ~/Downloads/vscode.zip
   ```

3. Install to Applications folder

   ```sh
   mv "~/Downloads/Visual\ Studio\ Code.app" /Applications/
   ```

4. Add it to path

   ```sh
   echo export PATH="'$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin'" >> ~/.zshrc
   ```
