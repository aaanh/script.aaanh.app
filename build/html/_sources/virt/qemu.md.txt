qemu
=======================

1. Create empty HDD image:

    ```zsh
    qemu-img create -f qcow2 name.img 69G
    ```

2. Boot from CDROM/ISO image:

    a. Linux
    ```zsh
    qemu-system-x86_64 -m 2048 -boot d -enable-kvm -smp 3 \
            -net nic -net user -hda name.img -cdrom ~/path/to/iso/image.iso
    ```

    b. macOS
    ```zsh
    qemu-system-x86_64 -m 2048 -boot d -accel hvf -smp 3 \
            -net nic -net user -hda name.img -cdrom ~/path/to/iso/image.iso
    ```

3. Go through installation for chosen distro on blank HDD image:
    

4. Boot from HDD image
    a. Linux
    ```zsh
    qemu-system-x86_64 -m 2048 -boot d -enable-kvm -smp 3 -net nic -net user -hda name.img
    ```
    b.macOS
    ```
    qemu-system-x86_64 -m 2048 -boot d -accel hvf -smp 3 -net nic -net user -hda name.img
    ```

```{note}
The process branches out for Linux and macOS due to different implementation of KVM on the systems.\
For Windows, please just use Hyper-V Manager to avoid the headaches.
```