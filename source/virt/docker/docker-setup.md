# Docker Setup

> This is adapted and abridged from <https://docs.docker.com>

## Installation

-   Remove old versions (if any)

```sh
sudo apt autoremove docker docker-engine docker.io containerd runc
```

-   Prepping up `apt`

```sh
sudo apt install ca-certificates curl gnupg lsb-release
```

-   Add Docker's GPG

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

```

-   Add Docker repository source

```sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

-   Install Docker Engine

```sh
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io
```
