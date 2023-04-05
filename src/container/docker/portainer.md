# Portainer

... is a web-based graphical interface to manage your containers. In all honesty, better than Docker Desktop. Should be ideal for managing in a headless server environment. However, Docker Desktop on Linux does come with that handy kubernetes switch which auto-deploys a cluster with all the necessary components for dev purposes.

> Adapted from Portainer's [official documentation](https://docs.portainer.io/start/install/server/docker/linux)

- Convenience one-liner

  ```
  docker volume create portainer_data && docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest
  ```

- Create volume
  ```
  docker volume create portainer_data
  ```

- Start the Portainer Server container
  ```
  docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest
  ```

  Note: If you are deploying the Community Edition instead, change portainer/portainer-ee to portainer/portainer-**c**e

- Server is live at: <https://localhost:9443>