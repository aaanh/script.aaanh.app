# System Operations

## Disable app armor

> Note: Applications like Docker Desktop would not start if app armor is enabled

```sh
echo 'kernel.apparmor_restrict_unprivileged_userns = 0' |
  sudo tee /etc/sysctl.d/20-apparmor-donotrestrict.conf
kernel.apparmor_restrict_unprivileged_userns = 0
```

## Font installation

Convenient script. I know I wrote Fedora but actually works for Debian-based as well, lol. Source: Trust me bro.

```sh
curl -O https://gist.githubusercontent.com/aaanh/2477c68314a144ee76de6858a57bed36/raw/fcd6a2dbbdc034f5f22c99c8085a1d6e575d293d/install-fonts-fedora.sh
```

## System Information

### ls\*

- `lspci`
- `lscpu`
- `lsblk`

### neofetch

## Resource Monitoring

### top or htop

For continuously querying resource usage. Simply open a terminal and run `top`.

`htop` has pretty formatting, not installed by default. Can be installed through common package managers.

## Logs

### journalctl

For `systemd`-based Linux operating system and/or distributions.

### dmesg

Kernel-level logs.

### /var/log/messages

This is where system log messages are stored in plain text.