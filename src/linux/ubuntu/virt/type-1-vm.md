# Kernel-based Virtual Machine

> Partially adapted from <https://ubuntu.com/blog/kvm-hypervisor>, <https://developer.hashicorp.com>. And with references to Red Hat article(s).

## Introduction

Refer to Red Hat's [article](https://www.redhat.com/en/topics/virtualization/what-is-KVM).

## Prerequisites

```sh
sudo apt install -y qemu qemu-kvm libvirt-daemon bridge-utils virt-manager libvirt-clients
```

## Start a VM

1. Create empty image

    Synopsis:

    ```
    qemu-img create -f <format> <vm-disk-name>.img <size><unit>
    ```

    Example:

    ```
    qemu-img create -f qcow2 some-vm.img 60G
    ```

2. Boot from CDROM/ISO image

    Synopsis:

    ```
    qemu-system-x86_64 -m <mem_size> -boot d -enable-kvm -smp 3 \
                         -net nic -net user -hda <vm-disk-name>.img -cdrom /path/to/downloaded/iso.iso
    ```

    Example:

    ```
    qemu-system-x86_64 -m 2048 -boot d -enable-kvm -smp 3 \
                         -net nic -net user -hda some-vm.img -cdrom ubuntu-22.04-amd64.iso
    ```

3. Go through the installation process of the respected distro onto the created VM image.
4. Shut down the VM.
5. Boot from the image with the installed OS

    Synopsis:

    ```
    qemu-system-x86_64 -m <mem_size> -boot d -enable-kvm -smp 3 \
                        -net nic -net user -hda <vm-disk-name>.img
    ```

    Example:

    ```
    qemu-system-x86_64 -m 2048 -boot d -enable-kvm -smp 3 -net nic -net user -hda some-vm.img
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

-   Installation

```sh
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list && sudo apt update && sudo apt install terraform
```

-   Libvirt provider <https://github.com/dmacvicar/terraform-provider-libvirt>
