Pip setup
===========

* Installing
```zsh
sudo apt update && sudo apt install python3 python-is-python3 python3-pip
```

* Export (installed) pip site package folder to path

```{note}
Assuming you're using zsh
```

```zsh
echo "export PATH=$PATH:~/.local/lib/python3.9/site-packages" >> ~/.zshrc && source ~/.zshrc
```

```{note}
Not using zsh, bash instead
```

```bash
echo "export PATH=$PATH:~/.local/lib/python3.9/site-packages" >> ~/.bashrc && source ~/.bashrc
```