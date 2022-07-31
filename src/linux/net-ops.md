# Network Operations

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
