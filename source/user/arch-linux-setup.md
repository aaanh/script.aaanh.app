# Arch Linux Setup

```{note}
This is an abridged version based on <https://wiki.archlinux.org/title/installation_guide> and <https://linuxiac.com/arch-linux-install/>. The purpose is to create a dumbed down guide that blasts past whatever precautions and warnings on the wiki. I. AM. SPEED. (Though is not gonna be as fast as this guy <https://www.youtube.com/watch?v=8utpbbdj0LQ>)
```

```{warning}
Make sure you have backed up all data before proceeding. This includes: your USB devices and your system disks.

**Disclaimer:** Proceed with the setup steps with extreme cautions. You must know what you are doing. I am not held responsible for your negligence.
```

## Download `.iso` image

[https://archlinux.org/download/](https://archlinux.org/download/)

Download script (using University of Waterloo repository mirror)

```sh
cd ~/Downloads && curl -O http://mirror.csclub.uwaterloo.ca/archlinux/iso/2022.02.01/archlinux-2022.02.01-x86_64.iso
```

## Create the USB installation medium with `dd`

```sh
dd if=/path/to/archlinux.iso of=/dev/somedisk bs=4M conv=fsync oflag=direct status=progress
```

Example:

```sh
dd if=~/Downloads/archlinux-2022.02.01-x86_64.iso of=/dev/sdb bs=4M conv=fsync oflag=direct status=progress
```

> Note: Use `lsblk` to list the disks mounted on your system. A USB device should typically be in the form of `sdx`.

## Restart and Boot into the USB

-   Lenovo: <kbd>Enter</kbd> &rightarrow; <kbd>F12</kbd>
-   Dell: <kbd>F12</kbd>
-   ASUS motherboard: <kbd>Delete</kbd> or <kbd>F2</kbd>

After a bit of initializations, you should now be staring at the live boot TTY command line as root, denoted by `#`.

## Networking

### Check the interfaces

```sh
ip link
```

If interface, `wlan0` for example, is shown as DOWN, do:

```sh
sudo ip link set wlan0 up
```

### Wireless (Taken straight from [Arch Linux Wiki](https://wiki.archlinux.org/title/lwd#iwctl))

```sh
iwctl
```

```sh
device list
```

```sh
station device scan
```

```sh
station device get-networks
```

```sh
station device connect SSID
```

### Wired

Should run without much configurations. Typically, installation occurs in a DHCP environment.

For static IP configurations

-   IP assignment

```sh
ip address show
```

```sh
ip address add address/prefix_len broadcast + dev interfaces
```

-   Routing table

```sh
ip route show
```

```
ip route add PREFIX via address dev interface
```

## Update `pacman` repository listing

```sh
pacman -Syy
```

## Create new partition table

```{warning}
Make sure you have backed up all data before proceeding. These steps assume that you are using a whole disk as installation target.
```

-   List available disks

```sh
fdisk -l
```

-   Create partition table

```sh
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

-   EFI System:

```
mkfs.fat -F32 /dev/sda1
```

-   Linux Swap:

```sh
mkswap /dev/sda2
swapon /dev/sda2
```

-   Linux Partition `/`:

```sh
mkfs.ext4 /dev/sda3
```

## Install Arch Linux

-   Mount root partition on system disk to live boot environment

```sh
mount /dev/sda3 /mnt
```

-   `pacstrap`-ing

```
pacstrap /mnt base linux linux-firmware sudo vim
```

> If PGP signature is not trusted, keyring needs to be updated.

```
pacman -Sy archlinux-keyring
```

## System Configurations

-   fstab

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

-   Change root into the installed system

```
arch-chroot /mnt
```

-   Timezone

```sh
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
```

-   Locale

> This `sed` script needs to be verified!!

```sh
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
```

Or manually:

```
vim /etc/locale.gen
```

-   Locale (cont.)

```sh
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
```

-   Hostname

```sh
echo "your-pc-name-of-choice" > /etc/hostname
```

```sh
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tyour_pc_name" > /etc/hosts
```

Should look something like this

```
# /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   your-pc-name
```

-   Set root password

```
passwd
```

## Install grub bootloader

```sh
pacman -S grub efibootmgr os-prober mtools
```

```sh
mkdir /boot/efi
mount /dev/sda1/ /boot/efi
grub-install --target=x86_64-efi --bootloader-id=grub_uefi
grub-mkconfig -o /boot/grub/grub.cfg
```

## Install Desktop Environment of choice

### Prerequisites

-   Install Xorg

```sh
pacman -S xorg-server xorg-apps
```

-   Install GPU drivers

```sh
# NVIDIA
pacman -S nvidia-utils

# AMD
pacman -S xf86-video-ati

# Intel
pacman -S xf86-video-intel
```

### Desktop Environments

Not all DE's are covered here. Only the 2 most used: gnome and kde. For other DE's, the Arch wiki covers them all.

-   GNOME

```sh
pacman -S gnome gnome-extra networkmanager
systemctl enable gdm
systemctl enable NetworkManager # THIS SHIT IS CASE-SENSITIVE
```

-   KDE

```sh
pacman -S xorg plasma plasma-wayland-session kde-applications networkmanager
systemctl enable sddm.service
systemctl enable NetworkManager # THIS SHIT IS CASE-SENSITIVE
```

## Create a user account

```sh
useradd -m -G wheel account_name
passwd account_name
EDITOR=vim visudo
```

-   Find and uncomment the line `# %wheel ALL=(ALL) ALL`

> In `vim` Normal Mode, type `/%wheel ALL=(ALL)` to search for that line. If you feel lazy, in Normal Mode, type `:set ignorecase` to ignore case for search query.

## Finalization

```sh
exit
umount -R /mnt
reboot
```

After the reboot, it should boot straight into the Arch installation on your system (assuming you have only 1 disk, 1 OS installed, lol).

## Userland

Refer to: <https://linux.hoanganh.tech/user/manjaro-first-setup.html>
