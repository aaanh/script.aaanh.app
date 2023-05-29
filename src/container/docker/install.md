# Docker Installation

## Linux

  ```sh
  curl -fsSL https://get.docker.com -o get.docker.sh && chmod +x get.docker.sh && sh ./get.docker.sh && rm ./get.docker.sh
  ```

## macOS

-   Apple Silicon

    ```sh
    curl -fsSL https://desktop.docker.com/mac/main/arm64/Docker.dmg -o ~/Docker.dmg && \
      sudo hdiutil attach Docker.dmg && \
      sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user=$(whoami) && \
      sudo /hdiutil detach /Volumes/Docker
    ```

-   AMDx64

    ```sh
    curl -fsSL https://desktop.docker.com/mac/main/amd64/Docker.dmg -o ~/Docker.dmg && \
      sudo hdiutil attach Docker.dmg && \
      sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user=$(whoami) && \
      sudo /hdiutil detach /Volumes/Docker
    ```

## Windows

### Enable virtualization features

1.  In your BIOS/UEFI firmware settings.
1.  Windows additional DISM features (src: [github repo](https://github.com/aaanh/autowin))

    ```powershell
    # 4. Enable optional features
    $win_features = "HypervisorPlatform","VirtualMachinePlatform","Microsoft-Windows-Subsystem-Linux","Microsoft-Hyper-V-All","Microsoft-Hyper-V","Microsoft-Hyper-V-Tools-All","Microsoft-Hyper-V-Management-Powershell","Microsoft-Hyper-V-Hypervisor","Microsoft-Hyper-V-Services","Microsoft-Hyper-V-Management-Clients"

    ForEach ($0 in $win_features) {
      Write-Host "Now installing $0..."
      dism /online /enable-feature /featurename:$0 /All /NoRestart
    }
    ```

> ⚠️ Restart your PC to apply the changes!

### Install (with PowerShell)

```powershell
Invoke-WebRequest -Uri "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe" -OutFile DockerDesktopInstaller.exe

Start-Process DockerDesktopInstaller.exe -Wait install --quiet --accept-license --backend="wsl-2"
```

> ⚠️ Make sure to re-login for Docker Desktop to work!
