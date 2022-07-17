# Firewall

For everyday run-of-the-mill configurations, `ufw` would suffice.

Allow common ports and protocols:

```{note}
Specifying **only** the ports will allow all inbound and outbound traffics through those ports for, both IPv4 and IPv6, both TCP and UDP.
```

```
sudo allow 80 | 443 |
```

Basic syntax:

```bash
ufw allow | deny <PORT> <PROTOCOL>
```

Controlling the `ufw` daemon:

```
sudo systemctl enable | disable | start | reload ufw
```

Check status:

```bash
sudo ufw status
```
