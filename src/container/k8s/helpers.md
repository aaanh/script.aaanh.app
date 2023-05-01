# Make Life Easier

## Tools

- `kubectx`: Quickly switch kubernetes context defined in `~/.kube/config`

  - Debian/Ubuntu

    ```sh
    sudo apt install kubectx
    ```

  - RHEL/Fedora

    Download the appropriate precompiled `kubectx` library at https://github.com/ahmetb/kubectx/releases/latest

- Merge kubeconfig files

  > ⚠️ This is a destructive command that might nuke your `~/.kube/config` file.

  ```sh
  export KUBECONFIG=~/.kube/config:/path/to/config/1:/path/to/config/2 && \
  kubectl config view --flatten > ~/.kube/config
  ```

## Aliases

```sh
echo "alias k=kubectl" >> ~/.$(echo $0 | tr -d '-')rc
echo "alias ktx=kubectx" >> ~/.$(echo $0 | tr -d '-')rc
```
