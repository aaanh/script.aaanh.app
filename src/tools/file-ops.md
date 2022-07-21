# File Operations

## File Transfer

### curl

### rsync

## Archival, compression, extraction

### tar

- Create

    ```
    tar zcvf target.tar.gz sourcefile
    ```

- Unpack

    ```
    tar zxvf sourcefile
    ```

- List

    ```
    tar ztvf sourcefile
    ```

### (un)zip

- Create zip archive from files

    ```sh
    zip -r <target> <source_folder>
    ```

- Extract/expand zip archive

    ```sh
    unzip <source_archive>
    ```

