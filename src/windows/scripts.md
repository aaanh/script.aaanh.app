# Convenience Scripts for Windows

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
dism TBA
```

## Disable 256-character path limit ⚠️

a.k.a. Enable long path

```powershell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
-Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

<details><summary>Explanation</summary>The command is taken from Microsoft's Docs. It adds an entry to the registry (GUI accessible through regedit) which allows the long path.</details>