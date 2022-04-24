# unix.hoanganh.tech

Rationale for this project: I got tired of Googling every time I do out-the-box setup an Ubuntu installation or VM.

The project is not intended for multi-hosts and orchestration scenarios, but for end-user semi-manual setups. However, in the future I do want to utilize orchestration tools for these tasks.

## Deployment

This repository CI is set up using GitHub Actions:

-   Trigger build and deployment when pushed to `prod` branch.
-   Deploy to a Debian server hosted on Linode.

## Updates

### 2022/04/18

Refactoring of topics and entries has commenced.

### 2022/03/22

Web server has been migrated from Apache2 to Nginx.
