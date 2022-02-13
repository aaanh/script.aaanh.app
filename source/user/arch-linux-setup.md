# Arch Linux Setup

```{note}
This is an abridged version based on <https://wiki.archlinux.org/title/installation_guide>. The purpose is to create a dumbed down guide that blasts past whatever precautions and warnings on the wiki. I. AM. SPEED. (Though is not gonna be as fast as this guy <https://www.youtube.com/watch?v=8utpbbdj0LQ>)
```

```{warning}
Make sure you have backed up all data before proceeding. This includes: your USB devices and your system disks.

**Disclaimer:** Proceed with the setup steps with extreme cautions. You must know what you are doing. I am not held responsible for your negligence.
```

## Download `.iso` image

[https://archlinux.org/download/](https://archlinux.org/download/)

Download script (using University of Waterloo repository mirror)

```
cd ~/Downloads && curl -O http://mirror.csclub.uwaterloo.ca/archlinux/iso/2022.02.01/archlinux-2022.02.01-x86_64.iso
```

## Create the USB installation medium with `dd`

```
dd if=/path/to/archlinux.iso of=/dev/somedisk bs=4M conv=fsync oflag=direct status=progress
```

Example:

```
dd if=~/Downloads/archlinux-2022.02.01-x86_64.iso of=/dev/sdb bs=4M conv=fsync oflag=direct status=progress
```

> Note: Use `lsblk` to list the disks mounted on your system. A USB device should typically be in the form of `sdx`.

## Restart and Boot into the USB

-   Lenovo: <kbd>Enter</kbd> &rightarrow; <kbd>F12</kbd>
-   Dell: <kbd>F12</kbd>
-   ASUS motherboard: <kbd>Delete</kbd> or <kbd>F2</kbd>

After a bit of initializations, you should now be staring at the live boot TTY command line as root, denoted by `#`.

## Networking

-   Check the interfaces

    ```
    ip link
    ```

### Wireless (Taken straight from [Arch Linux Wiki](https://wiki.archlinux.org/title/lwd#iwctl))

    ```
    iwctl
    ```

    ```
    device list
    ```

    ```
    station device scan
    ```

    ```
    station device get-networks
    ```

    ```
    station device connect SSID
    ```

### Wired

Should run without much configurations. Typically, installation occurs in a DHCP environment.

For static IP configurations

-   IP assignment

```
ip address show
```

```
ip address add address/prefix_len broadcast + dev interfaces
```

-   Routing table

```
ip route show
```

```
ip route add PREFIX via address dev interface
```

## Update `pacman`

```
pacman -Syyu
```

## Create new partition table

```{warning}
Make sure you have backed up all data before proceeding. These steps assume that you are using a whole disk as installation target.
```

-   List available disks

```
fdisk -l
```

-   Create partition table

```
cfdisk /dev/sdx
```

-   If prompted for label type, select `gpt`.

-   Delete all partitions.

Partition table should be:

| Partition | Type                 | Size             | Format |
| --------- | -------------------- | ---------------- | ------ |
| /dev/sda1 | EFI System Partition | 512M             | FAT32  |
| /dev/sda2 | Linux Swap           | 4G               |        |
| /dev/sda3 | Linux Partition      | <kbd>Enter</kbd> | EXT4   |

-   Write changes to disk.

## Formatting the partitions

-   EFI System Partition

```
mkfs.fat -F32 /dev/sda1
```
