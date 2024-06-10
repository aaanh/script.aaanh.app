# RHEL/Fedora/CentOS Out-of-the-Box Experience

> Note: Cool thing about Fedora is that most dev-centric packages are already installed :)

> Another one: These commands are exclusively tested out on Fedora, but probably are transferable to RHEL and CentOS as well.

## Convenience script

### Out of the box experience

Static file: [/static/scripts/fedora-oobe.sh](/static/scripts/fedora-oobe.sh)

```bash
curl https://script.aaanh.app/static/scripts/fedora-oobe.sh | bash
```

### Development tools

It is recommended to run the OOBE script first to get the dependencies.

Static file: [/static/scripts/fedora-dev-tools.sh](/static/scripts/fedora-dev-tools.sh)

```bash
curl https://script.aaanh.app/static/scripts/fedora-dev-tools.sh | bash
```

## Update

```bash
sudo dnf update
```

## Install common applications

### For general user

```bash
sudo dnf -y install zsh wget curl neovim
```

### For developers

```bash
sudo dnf -y install nodejs gcc-c++
```

#### Github CLI

```bash
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh
gh auth login
```

#### Docker

```bash
sudo dnf -y install dnf-plugins-core
```

```bash
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh
```

## Set up `zsh`

> Change default shell using `usermod` instead because `chsh` is not installed by default

```bash
sudo usermod -s /usr/bin/zsh "$(whoami)"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"
sed -i 's/robbyrussell/flazz/g' ~/.zshrc
```

## Set up `vim`

```sh
git clone https://github.com/aaanh/vimrc ~/.vim_runtime && cd ~/.vim_runtime && ./install_awesome_vimrc.sh
```
