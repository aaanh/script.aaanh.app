# Network Operations

## Information Query

### ipconfig

- Detailed list of network interfaces, much like Linux `ip address`

  ```powershell
  ipconfig /all
  ```

### tracert (Trace route)

```powershell
tracert <IP | FQDN>
```

### dig (DNS lookup)

```powershell
dig <IP | FQDN>
```

### nslookup (Nameserver lookup)

Most effective when used to look into a certain web address, e.g. google.com, rather than an IP address.

```powershell
nslookup <FQDN | IP>
```