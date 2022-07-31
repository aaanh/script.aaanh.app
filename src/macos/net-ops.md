# Network Operations

## Information Query

### traceroute (Trace packets route)

- Default and simple

  ```sh
  traceroute/tracert <IP | FQDN>
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

- List interfaces

  ```
  ipconfig getiflist
  ```

- Get IP address of the Mac machine on LAN

  ```
  ipconfig getifaddr en0
  ```

- Summary of the interface

  ```
  ipconfig getsummary en0
  ```