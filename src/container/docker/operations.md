# Docker Operations

> The commands written below are examples, all options, `--<option>` or `-<o>`, are optional.

- Build

  ```
  docker build </path/to/context/folder> -t <my-docker-image>:<tag-version>
  ```

- Start a container from an image

  ```
  docker run -dp <host_port>:<container_port> <my-docker-image>:<tag-version> -n <container-name>
  ```

  Note:
  - `-d`: Run in detached mode. You won't be presented with the container stdout in the terminal.
  - `-n`: If not specified, Docker will randomly generate one.

- Remote into a running container

  ```
  docker exec -it <host_port>:<container_port> <my-docker-image>:<tag-version> --tty --stdin -- /bin/bash
  ```

  Note: 
  - For some minimal containers, the entrypoint should be `/bin/sh`
  - `--it`: Run in interactive mode

- List

  - Images
    ```
    docker image ls
    ```
  - Containers
    ```
    docker container ls
    ```

- Stop
  
  ```
  docker stop <container-name>
  ```
  
- Delete
 
  - Images
    ```
    docker rm image-tag:tag-version # e.g. nginx:latest
    ```
  - Containers
    ```
    docker rm container-name
    ```
  - Prune
    ```
    docker prune -a
    ```
    Note: `-a` option will prune images not being used by a container (stopped also qualifies). By default, it deletes images that are not tagged.