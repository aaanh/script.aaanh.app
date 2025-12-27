# Requires: Run as current user, not admin. Some actions require restart of Explorer.

# Function to unpin all taskbar items
function Clear-Taskbar {
    $taskbarPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
    Remove-Item "$taskbarPath\*" -Force -ErrorAction SilentlyContinue
    # Clear registry references
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name Favorites -ErrorAction SilentlyContinue
    Stop-Process -Name explorer -Force
}

# Function to pin app using StartLayout XML (only works on fresh profile or via provisioning)
function Pin-App {
    param (
        [string]$AppUserModelID
    )
    $script = @"
\$a = New-Object -ComObject Shell.Application
\$b = \$a.NameSpace((Join-Path \$env:windir 'explorer.exe'))
"@
    Invoke-Expression $script
}

# Alternative: Use .lnk method for File Explorer and Terminal
function Pin-Lnk {
    param (
        [string]$target,
        [string]$shortcutName
    )
    $shortcutPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\$shortcutName.lnk"
    $WshShell = New-Object -ComObject WScript.Shell
    $shortcut = $WshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $target
    $shortcut.Save()
}

function Download-And-Import-Dark-Mode-Classic-Menu-Reg {
    param (
        [string]$url,
        [string]$regFileName = "dark-mode-classic-menu.reg"
    )

    $regFilePath = Join-Path $env:TEMP $regFileName

    # Download .reg file
    Invoke-WebRequest -Uri $url -OutFile $regFilePath -UseBasicParsing

    # Import the .reg file
    reg import $regFilePath
}

# Clear existing pinned items
Clear-Taskbar

# Pin File Explorer
Pin-Lnk -target "C:\Windows\explorer.exe" -shortcutName "File Explorer"

# Pin Windows Terminal (MS Store UWP version)
$terminalPath = "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_*\WindowsTerminal.exe"
$resolved = Get-ChildItem $terminalPath -ErrorAction SilentlyContinue | Select-Object -First 1
if ($resolved) {
    Pin-Lnk -target $resolved.FullName -shortcutName "Windows Terminal"
}

# Pin Settings (via shell command shortcut)
$settingsLnk = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Settings.lnk"
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut($settingsLnk)
$shortcut.TargetPath = "ms-settings:"
$shortcut.Save()

# Restart Explorer to reflect changes
Stop-Process -Name explorer -Force

# Merge the dark mode classic menu registry
Download-And-Import-Dark-Mode-Classic-Menu-Reg -url "https://script.aaanh.app/static/scripts/dark-mode-classic-menu.reg"