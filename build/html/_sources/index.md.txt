---
hide-toc: true
---

Anh's Linux Documentation \(ALD\)
===============================================

Homepage: <https://hoanganh.tech>

ALD is my opinionated copy-paste scripts and commands for referencing when I set up my work environment in Linux-based distributions (over and over again).

```
Current build: v1.1.0
Latest change: Added Enhanced Session Hyper-V configs; fixed wrong lexer name.
```

```{warning}
   Utilize at your own risks.
```

This docs is hosted on a Linux VM.

#### System Information \(neofetch\):

```{include} ./host-info.md
```

```{toctree}
:hidden:
:caption: Userland
user/ubuntu-debian-first-setup
user/manjaro-arch-first-setup
```

```{toctree}
:hidden:
:caption: Virtualization
virt/qemu
virt/enhanced-session
```

```{toctree}
:hidden:
:caption: Remote Desktop
remote/xrdp-server
```

```{toctree}
:hidden:
:caption: General tools
tool-tips
```