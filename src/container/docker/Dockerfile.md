# Dockerfile

... is a declarative file for building a container from a base image. Simply put, analogous to the commands you'd run when setting up a virtual machine.

Example Dockerfile to build an image that can run Nodejs applications using Microsoft's base Linux image.

```Dockerfile
# base image
FROM mcr.microsoft.com/cbl-mariner/base/core:2.0

# Copy from the working directory where `docker build . -f Dockerfile` is executed
COPY . .

# Specify workdir in the container, abitrary dir name
WORKDIR /app

# Install dependencies
RUN yum install -y nodejs npm ca-certificates

# Export some environment variables to the container environment
ENV NODE_EXTRA_CA_CRT="/path/to/those/ca/cert.crt"

# ---- Creating an example nodejs application ----
RUN npm init -y
RUN echo "console.log(\"Hello world!\"); console.log(process.env)" >> index.js

# Set the entrypoint: executed when the container is started.
ENTRYPOINT ["node", "index.js"]
```

- Try it out

- Create the Dockerfile locally, copy and paste the content above

- Build and run

  ```
  docker build . -t test && docker run test
  ```

- Expect

  ```yaml
  Hello world!
  {
    PATH: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    HOSTNAME: '5b1d8f97d2ce', # yours could be anything else
    NODE_EXTRA_CA_CRT: '/path/to/those/ca/cert.crt',
    HOME: '/root'
  }
  ```