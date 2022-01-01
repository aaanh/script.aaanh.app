# Tool Tips

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

```zsh
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

```zsh
find . -name '*.jpg'
```

## top

Synopsis: Real-time resource and process monitoring

-   Usage with pipe `|` and `grep`

```zsh
top | grep -i "a_very_safe_java_program"
```

## netcat

Sypnosis: `cat` network info

- See which ports are in use

```zsh
sudo netstat -tunlp
```