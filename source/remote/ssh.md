# SSH

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
