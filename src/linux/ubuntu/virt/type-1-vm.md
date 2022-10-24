# Kernel-based Virtual Machine

> Partially adapted from <https://ubuntu.com/blog/kvm-hypervisor>, <https://developer.hashicorp.com>. And with references to Red Hat article(s).

## Introduction

Refer to Red Hat's [article](https://www.redhat.com/en/topics/virtualization/what-is-KVM).

## Prerequisites

```sh
sudo apt install -y bridge-utils libvirt-clients libvirt-daemon qemu qemu-kvm
```

## Start a VM

- Synopsis

  ```sh
  sudo virt-install --name some_name --os-variant distro_name_version --vcpus Int --ram MB<Int> --location distro_download_url --network bridge=some_bridge,model=some_model --graphics none --extra-args='console=ttyS0,115200n8 serial'
  ```

- Example

  ```sh
  sudo virt-install --name ubuntu-guest --os-variant ubuntu20.04 --vcpus 2 --ram 2048 --location http://ftp.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/ --network bridge=virbr0,model=virtio --graphics none --extra-args='console=ttyS0,115200n8 serial'
  ```

## Management

### Virtual Machine Manager

```
sudo apt install virt-manager
```

GUI for easier management.

### Vagrant

Infrastructure-as-Code implementation of VM and container management by HashiCorp.

```sh
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && sudo apt update && sudo apt install vagrant
```

### Terraform

Infrastructure-as-Code implementation of VM, container, network stackc management also by HashiCorp.

- Installation

```sh
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list && sudo apt update && sudo apt install terraform
```

- Libvirt provider
  <https://github.com/dmacvicar/terraform-provider-libvirt>