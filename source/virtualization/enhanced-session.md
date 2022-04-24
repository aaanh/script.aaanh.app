# Hyper-V Enhanced Session

## Prerequisites

-   Administrator privilege
-   CPU that supports level 1 hypervisor virtualization
-   Windows 10 Pro edition (build >= 20H1)

## Windows host configurations

The following Windows Features must be turned on:

-   Hyper-V
-   Windows Hypervisor Platform
-   Virtual Machine Platform

Scripts execution in Powershell must be allowed:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```

During Ubuntu VM creation:

-   Select Generation 2 VM
-   Disable secure boot
-   Name VM as something tolerable, e.g. linux-test, i.e. `$vmName`.

## Debian guest configurations

```{note}
This assumes that [first setup](/oobe/ubuntu-first-setup) has been done.
```

1. Clone git repo containing bash script.

    ```sh
    git clone https://github.com/Hinara/linux-vm-tools ~/linux-vm-tools
    ```

2. Make `.sh` executable in user context and execute the script as superuser.

    ```sh
    chmod +x ~/linux-vm-tools/ubuntu/20.04/install.sh \
    sudo ~/linux-vm-tools/ubuntu/20.04/install.sh
    ```

3. Reboot VM.

    ```sh
    sudo reboot
    ```

4. Re-run the script to finalize.

    ```sh
    sudo ~/linux-vm-tools/ubuntu/20.04/install.sh
    ```

5. Shut down and stop VM completely.

6. Open up Powershell as Administrator and configure newly created VM to use HvSocket
    ```powershell
    Set-VM -VMName $vmName -EnhancedSessionTransportType HvSocket
    ```
7. Boot up VM and will be meet with xrdp log in screen. If not, then screwed up somewhere.
