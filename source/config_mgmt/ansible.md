# Ansible

## Setup for controller node

```
python3 -m pip install ansible
```

```
brew install ansible
```

```
sudo apt install ansible
```

## Configuring `ssh`

Ansible relies on `ssh` to run the tasks. So, having at least some basic configurations for `ssh` client-side is purposedly a convenience.

### Client (Control Node)

-   Example content of `~/.ssh/config`

```
Host friendly_name
    HostName 123.69.0.2 (or sub.domain.tld)
    User root (or non root)
    IdentityFile /path/to/private_key
```

### Host (Managed Node)

-   Must have `python` installed.

## Configurations on Control Node

-   Example content of `ansible.cfg` file

```ini
[defaults]
INVENTORY = inventory
```

-   Example content of `inventory` file

```ini
[name_of_inventory_group]
hostname1.domain.tld
hostname2.domain.tld
```

## Command Overview

-   Run a task against a specified (group of) host(s).

```
ansible <inventory_group> [-m command by default] -a(rgument) "<command_to_run_on_remote>" -u(ser) <remote_user>
```

```{note}
Head over to </ansible/vagrant> for building virtual machines.
```
