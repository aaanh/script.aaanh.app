# File Operations

## Create

- Single file

  ```powershell
  New-Item -Path . -Name "my_file.txt" -ItemType "file" -Value "lorem ipsum"
  ```

- Directory

  ```powershell
  New-Item -Path ../ -Name "my_directory" -ItemType "directory"
  ```

  > Omit `-Name` and use a relative path, e.g. `path/to/my_new_dir` instead for a quicker operation, result in a directory named `my_new_dir`.

## Delete

> TBA

## Copy

### Robocopy

> TBA

## File Info

> No native equivalent to Linux `file`.

## File Content

- With Powershell

```powershell
Get-Content file.txt
```

- With Command Prompt (pipe into `MORE` for scrolling)

```cmd
TYPE file.txt | MORE
```