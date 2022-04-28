# unix.hoanganh.tech

<p><a class="reference external" href="https://github.com/aaanh/linux-docs/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/aaanh/linux-docs?style=social" /></a>  <a class="reference external" href="https://twitter.com/intent/tweet?text=Wow:&amp;url=https%3A%2F%2Fgithub.com%2Faaanh%2Flinux-docs"><img alt="Twitter" src="https://img.shields.io/twitter/url?style=social&amp;url=https%3A%2F%2Fgithub.com%2Faaanh%2Flinux-docs" /></a></p>
<p><img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/aaanh/linux-docs/CI?style=for-the-badge&amp;label=Development" /> <img alt="GitHub Workflow Status (branch)" src="https://img.shields.io/github/workflow/status/aaanh/linux-docs/CI/prod?label=Production&amp;style=for-the-badge" /></p>

Rationale for this project: I got tired of Googling every time I do out-the-box setup an Ubuntu installation or VM.

The project is not intended for multi-hosts and orchestration scenarios, but for end-user semi-manual setups. However, in the future I do want to utilize orchestration tools for these tasks.

## Deployment

This repository CI is set up using GitHub Actions:

-   Trigger build and deployment when pushed to `prod` branch.
-   Deploy to a Debian server hosted on Linode.

> I am also currently testing container-based deployments. This is being done on Google Cloud Run privately. The site is exposed on <https://aaanh.app>

## Local Development

### Native

- Requires `python>=3.8` and `pip`.
- Install dependencies: `pip install -r requirements.txt`.
- Navigate to `./build/html` and view `index.html` with your favorite browser.
- **OR** serve the `./build/html` folder with a simple http server.

### Docker Container

- `docker build . -t linux-docs:dev`.
- `docker run -dp 80:8000 linux-docs`.
- Navigate to `localhost:8000` on local browser.

## Contributions


> Please use common sense and follow [Github Community Guidelines](https://docs.github.com/en/site-policy/github-terms/github-community-guidelines).


- Fork the repository
- Do your thing
- Commit with meaningful description
- Push to your fork repository
- Create pull request

## Updates

### 2022/04/18

Refactoring of topics and entries has commenced.

### 2022/03/22

Web server has been migrated from Apache2 to Nginx.
