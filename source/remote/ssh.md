# SSH

## Use cases

-   Simple `ssh` connection

    ```
    ssh <user>@<remote-server>
    ```

    Where,

    -   user = user on the remote server
    -   remote-server = domain name or IP address

-   Tunnel or port forwarding

    ```
    ssh -L <local-port>:<remote-server>:<server-port> <jump-server>
    ```

    Example:

    ```
    ssh -L 8080:ssh.example.com:9090 -N -f root@ssh.example.com
    ```

    Where,

    -   `-L` specifies the target remote server to `ssh` into.
    -   `-N` specifies the session is non-interactive.
    -   `-f` specified the `ssh` client to run in background.
    -   `root` is the user on the remote jump server.

    Note: The jump server could be standalone (different domain name/IP address) or could be the same as remote server.

## SSH Keypair

-   Create

```
ssh-keygen -t rsa -b 4096
```

or

```
ssh-keygen -t ecdsa -b 521
```

-   Copy key to server

```
ssh-copy-id -i ~/.ssh/key_id <remote_user>@<host>
```

```{warning}
Storing ssh keypairs in plain text is a security risk. Consider using a hardened management system to store such keys.
```
