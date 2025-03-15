# Convenience Scripts for Windows

> ℹ️ Active development of an OOBE PWSH script project over at [https://github.com/aaanh/autowin](https://github.com/aaanh/autowin). This project does most of the below and more.

## Install oh-my-posh

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget 
```

## Fish-like autosuggestion for powershell

- Install

```powershell
Install-Module PSReadLine -RequiredVersion 2.1.0
```

- Init

```powershell
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
```

## Shut down a remote PC

```powershell
shutdown -r -m \\MACHINE-NAME.<domain>.<tld>
```

## Execution Policy ⚠️

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

<details><summary>Explanation</summary>By default, the policy is set to <code>Restricted</code>: commands can be typed and run in the shell, but cannot run a script file. <code>RemoteSigned</code> is the minimal policy that allows it.</details>

## Virtualization Features ⚠️

Required for: Windows Subsytems for Linux, Hyper-V, Docker

```powershell
$win_features = "HypervisorPlatform", "VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux", "Microsoft-Hyper-V-All", "Microsoft-Hyper-V", "Microsoft-Hyper-V-Tools-All", "Microsoft-Hyper-V-Management-Powershell", "Microsoft-Hyper-V-Hypervisor", "Microsoft-Hyper-V-Services", "Microsoft-Hyper-V-Management-Clients"

ForEach ($0 in $win_features) {
  Write-Host "Now installing $0..."
  dism /online /enable-feature /featurename:$0 /All /NoRestart
}
```

## Disable 256-character path limit ⚠️

a.k.a. Enable long path

```powershell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
-Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

<details><summary>Explanation</summary>The command is taken from Microsoft's Docs. It adds an entry to the registry (GUI accessible through regedit) which allows the long path.</details>
