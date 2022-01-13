# Linux Kernel Development Environment

```{note}
This applies to the Ubuntu distro with `apt` as the package manager.
- Adapted from: <https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel>
- Learning material: <https://sysprog21.github.io/lkmpg>
- Personal learning repo: <https://github.com/aaanh/linux-kernel-learn>
```

1.  Dependencies

    -   Add deb-src to sources.list first. Note: Needs superuser privilege.

    ```zsh
    echo -e "deb-src http://archive.ubuntu.com/ubuntu impish main\ndeb-src http://archive.ubuntu.com/ubuntu impish-updates main" | sudo tee -a /etc/apt/sources.list > /dev/null
    ```

    -   Or add the sources manually

    ```zsh
    deb-src http://archive.ubuntu.com/ubuntu impish main
    deb-src http://archive.ubuntu.com/ubuntu impish-updates main
    ```

    ```zsh
    sudo vim /etc/apt/sources.list
    ```

    -   Now, install the dependencies.

    ```zsh
    sudo apt-get build-dep linux linux-image-$(uname -r) libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf
    ```

2.  Host system configurations

    -   Secure Boot disabled in BIOS
        -   This security feature prevents loading self-programmed kernel modules by the kernel due to unsigned binaries.
    -   That's it, for now.

3.  Commands:
    -   `# insmod <module.ko>`: install the module.
    -   `# rmmod <module_name>`: remove the module.
    -   `$ journalctl | tail`: output the systemd journal and pipe into `tail` to get most recent lines.
    -   `# dmesg`: output the kernel ring buffer, requires superuser privilege. No need for tail because it's ordered by latest.
