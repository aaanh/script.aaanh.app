# Network Operations

## SSH

- Simple `ssh` connection

  ```sh
  ssh username@hostname
  ```

- Tunneling

  ```sh
  ssh username@server_1 -N -f -L local_port:server_2:remote_port
  ```

- Relay with port-forwarding

  Synopsis:

  ```sh
  ssh -L port_a:localhost:port_b username@server_1 sshpass -p password_for_server_2 ssh -L port_b:localhost:port_c -N username@server_2
  ```

  Example:

  ```sh
  ssh -L 3333:localhost:4444 foo@server-1.example.com sshpass -p s0mePa$$w0rd ssh -L 4444:localhost:3389 -N email@example.com@server-2.example.com
  ```
  > Note: This scenario was tested with a 3 machines. The physical Windows machine with ssh (client), a Debian server (`server_1`) on Linode VPS, and a Windows RDP host (`server_2`). `server_1` and `server_2` have VPN tunneling with Tailscale.
  >
  > In order for this to work, `server_2` must have OpenSSH Server service enabled and **running**. `server_1` must have `sshpass` installed, the in and out ports whitelisted with `ufw`.
  >
  > This is just a makeshift method in desperate times. Looking for better ways in the future.

## Firewall

### ufw

Might need to install first on some distributions or barebone server images.

It is basically a convenient wrapper for `iptables` and `netfilter`. Hence, (U)ncomplicated(F)ire(w)all.

> ⚠️ Proceed with caution. Incorrectly configuring your system firewall might result in massive failures on dependent systems and network nodes.

- Show status

  ```sh
  sudo ufw status
  ```

- Enable/Disable

  ```sh
  sudo ufw enable # or disable
  ```

> Swap `allow` with `deny` for the opposite effect.

- Allow port for both tcp and udp.

  ```sh
  ufw allow 6969
  ```

- Allow common protocol by name for only tcp.

  ```sh
  sudo ufw allow http/tcp
  ```

- Allow source and destination IP subnet range with specified protocol and port range.

  ```sh
  sudo ufw allow proto tcp from 10.0.0.1/24 to 192.0.0.2/28 port 69:420
  ```

## Information Query

### traceroute/tracert (Trace packets route)

- Default and simple

  ```sh
  traceroute <IP | FQDN>
  ```

- Specify max number of hops

  ```sh
  traceroute -m <int> <IP | FQDN>
  ```

- Example

  ```sh
  traceroute -m 42069 google.com
  ```

### dig (DNS lookup)

```sh
dig <IP | FQDN>
```

### nslookup (Nameserver lookup)

Most effective when used to look into a certain web address, e.g. google.com, rather than an IP address.

```sh
nslookup <FQDN | IP>
```

### ip/ipconfig/ifconfig

- List network interfaces with status, Physical MAC address, IP address, and subnet.

  ```
  ip address
  ```

## Virtual Private Network (VPN)

### Tailscale

[Tailscale](https://tailscale.com) is a VPN service that uses [WireGuard](https://www.wireguard.com/) protocol. If you are looking for a fully OSS alternative to Tailscale, you can check out [Headscale](https://github.com/juanfont/headscale) instead.

Tailscale can be virtually installed and used across all popular platforms. Maybe except for z/OS?

- Create Tailscale account: https://login.tailscale.com/start (I personally use Github SSO provider)
- Installation

  This script is provided on Tailscale official web documentation.

  ```sh
  curl -fsSL https://tailscale.com/install.sh | sh
  ```

- Start the service

  ```sh
  sudo tailscale up
  ```

- Follow the instructions and complete the setup.
- Some use cases I have experimented with:
  - Simply connect with VPN'd devices.
  - [Set up exit nodes](https://tailscale.com/kb/1103/exit-nodes/) to bypass geo-locking.
  - [Set up a relay node](/linux/net-ops.html#ssh) to access systems connected to the VPN service.