# KVM Hypervisor Setup

```{note}
This doc assumes that your host system CPU is capable of kvm virtualization (type 1 hypervisor).
```

```zsh
sudo apt update && sudo apt install -y qemu qemu-kvm libvirt-daemon bridge-utils virt-manager libvirt-clients
```
