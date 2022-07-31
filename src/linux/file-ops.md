# File Operations

## File Transfer

### curl

- Download and Save file with name extracted from the URL

    ```sh
    curl https://example.com/my-file.sh -O
    ```

- Download and Save file with specified name

    ```sh
    curl https://example.com/my-file.sh -O my-downloaded-file.sh
    ```

### rsync

- Commonly used command

    ```sh
    rsync -avzP /PATH/TO/LOCAL/MY_FILE_FOLDER/ user@destination_machine:~/SOME_PARENT_FOLDER/
    ```

> Explanation: (a)rchive, (v)erbose, (z)ip, (P)artial/(P)rogress. `SOURCE` is the first argument, `DESTINATION` comes second. So, to copy from a remote machine, simply swap the arguments above.

- Example
    ```sh
    rsync -avzP ~/Documents/assination_orders/ account_payables@high_table.xyz@10.0.0.69:~/Documents/orders_to_execute/
    ```

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

## Finding and Searching

### grep

### find
