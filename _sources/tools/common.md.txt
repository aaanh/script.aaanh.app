# Common Tools and Commands

These tools can be run on every OS, given that it is installed.

## scp (Secure CoPy)

-   Copy from local (source) to remote (destination)

```zsh
scp /path/to/local_file.asm remote_user@remote_server:/remote/folder/
```

-   Copy from remote (source) to local (destination). Performed on local shell.

```zsh
scp remote_user@remote_server:/remote/folder/ /path/to/local_destination
```

```{note}
Full path needed if destination is Windows. E.g. `c:\users\local_user\...`

Tidbit: Tested to be working on Windows - Windows situation with both having openssh optional feature available.
```

## tar

-   Create

```zsh
tar zcvf target.tar.gz sourcefile
```

-   Unpack

```zsh
tar zxvf sourcefile
```

-   List

```zsh
tar ztvf sourcefile
```

## curl

-   Default retrieval

```zsh
curl [url]
```

-   Specified output

```zsh
curl -o [target] [url]
```

-   Same output as source

```shell
curl -O [url]
```

## which

Sypnosis: Returns the path to executable for the command line program. Not the symlink.

-   Simple usage

```zsh
which <command line program>
```

## find

Sypnosis: Recursively returns the filepaths that match the supplied regex.

-   Simple usage

```shell
find . -name '*.jpg'
```

## top

Synopsis: Real-time resource and process monitoring

-   Usage with pipe `|` and `grep`

```shell
top | grep -i "a_very_safe_java_program"
```

## netstat

Sypnosis: net(work) stat(us)

-   See which ports are in use

```console
sudo netstat -tunlp
```
