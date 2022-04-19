# Docker

> This is adapted and abridged from <https://docs.docker.com>

## Setup

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

## Docker Quick Start

### Overview

Roughly, Docker is a virtualization platform on the OS-level. It is intended for hosting extremely barebone and lightweight applications and services, but can also scale up, implement HA, and fail over via other management and orchestration services.

### Abstraction layers

-   A **container** is basically a VM. E.g. ubuntu, kalilinux, nginx, http, node.
-   A (base) **image** is pulled from Docker repository and used (loosely) as the container "OS". E.g. my-lightweight-vm-based-on-debian
-   A **volume** acts as a virtual external disk for a given container. E.g. my-vm-data-store
-   A **pod** or **swarm** is a group or cluster of containers.
    > Swarm is also a docker service. Pod is a terminology from Kubernetes.

### Spin up the first container

```bash
docker pull ubuntu && docker run -it ubuntu
```

### List all containers

```bash
docker container ls # or docker ps
```

### List all pulled images

```bash
docker image ls
```

### Start an existing container

```bash
docker start container_name
```

### Attach to a running container

```bash
docker attach container_name
```

> If a container has a terminal shell running, attaching to it will drop you to the shell. If a container does not have an interactive shell, this will attach to the `stdout` pipe depending on the base image.

### Removal

-   Image

```bash
docker image rm image_name
```

-   Container

```bash
docker container rm container_name
```
