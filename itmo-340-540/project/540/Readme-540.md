# Project

## Information Table

This is the information table your will need to fill out for the remaining questions of the assignment. Assume this information is the state of the network at the beginning of the questions -- various actions in the questions may change this state.

### ITM Network

PC A

| Field | Value |
| -- | ------|
| IP Address | - |
| Subnet | - |
| Default Gateway | - |
| DNS Server | - |
| MAC Address | B4:74:9F:88:4E:43 |

PC B

| Field | Value |
| -- | ------|
| IP Address | 192.168.1.11 |
| Subnet | 255.255.255.0 or /24 |
| Default Gateway | 192.168.1.254 |
| DNS Server | 192.168.3.4 |
| MAC Address | B4:74:9F:88:4E:44 |

PC C - DHCP Server

| Field | Value |
| -- | ------|
| IP Address | 192.168.1.3 |
| Subnet | 255.255.255.0 or /24 |
| Default Gateway | 192.168.1.254 |
| MAC Address | B4:74:9F:88:4E:45 |
| DHCP Address Offer range | 192.168.1.10-20 |
| DHCP Subnet | /24 or 255.255.255.0 |
| DHCP Default Gateway | 192.168.1.254 |
| DHCP Server Address | 192.168.1.3 |
| DNS Server | 192.168.3.4 |

### Computer Science Network

PC A

| Field | Value |
| -- | ------|
| IP Address | - |
| Subnet | - |
| Default Gateway | - |
| MAC Address | B4:74:9F:88:01:00 |

PC B

| Field | Value |
| -- | ------|
| IP Address | 192.168.2.2 |
| Subnet | 255.255.255.0 |
| Default Gateway | 192.168.2.254 |
| MAC Address | B4:74:9F:88:02:00 |
| DNS Server | 192.168.3.4 |

PC C - DHCP Server

| Field | Value |
| -- | ------|
| IP Address | 192.168.2.3 |
| Subnet | 255.255.255.0 or /24 |
| Default Gateway | 192.168.2.254 |
| MAC Address | B4:74:9F:88:03:00 |
| DHCP Address Offer range | 192.168.2.10-20 |
| DHCP Subnet | /24 or 255.255.255.0 |
| DHCP Default Gateway | 192.168.2.254 |
| DHCP Server Address | 192.168.2.3 |
| DNS Server | 192.168.3.4 |

### Applied Math Network

PC A

| Field | Value |
| -- | ------|
| IP Address | - |
| Subnet | - |
| Default Gateway | - |
| MAC Address | B4:74:9F:01:10:56 |

PC B

| Field | Value |
| -- | ------|
| IP Address | 192.168.3.2 |
| Subnet | /24 or 255.255.255.0 |
| Default Gateway | 192.168.3.2 |
| MAC Address | B4:74:9F:02:10:56 |

PC C - DHCP Server

| Field | Value |
| -- | ------|
| IP Address | 192.168.3.3 |
| Subnet | 255.255.255.0 or /24 |
| Default Gateway | 192.168.3.254 |
| MAC Address | B4:74:9F:03:10:56 |
| DHCP Address Offer range | 192.168.3.10-20 |
| DHCP Subnet | /24 or 255.255.255.0 |
| DHCP Default Gateway | 192.168.3.254 |
| DHCP Server Address | 192.168.3.3 |
| DNS Server | 192.168.3.4 |

PC D - DNS Server

| Field | Value |
| -- | ------|
| IP Address | 192.168.3.4 |
| Subnet | 255.255.255.0 or /24 |
| Default Gateway | 192.168.3.254 |
| MAC Address | B4:74:9F:04:10:56 |
| DNS A Record | fusion.cs.iit.edu, 192.168.2.2, A |
| DNS A Record | oldserver.cs.iit.edu, 192.168.2.5, A |
| DNS A Record | netflix.com, 172.16.0.10, A |

### Netflix Network

PC A - Netflix Server

| Field | Value |
| -- | ------|
| IP Address | 172.16.0.10 |
| Subnet | 255.255.0.0 or /16 |
| Default Gateway | 172.16.0.1 |
| DNS Server | 192.168.3.4 |
| MAC Address | B4:74:9F:00:00:01 |

### Netflix Router

Netflix Router Interface

| IP Address | 172.16.0.1 |
| Subnet | 255.255.0.0 or /16 |
| MAC Address | B4:74:9F:00:00:02 |

### School Network Router

The router has four interfaces

| Field | Value | Output Interface Number |
| ----- | -------- | ------ |
| ITM NIC IP | 192.168.1.254 | 0 |
| ITM NIC MAC | 34:98:B5:00:00:01 | - |
| Computer Science NIC IP | 192.168.2.254 | 1 |
| computer Science NIC MAC | 34:98:B5:00:00:02 | - |
| Applied Math NIC IP | 192.168.3.254 | 2 |
| Applied Math NIC MAC | 34:98:B5:00:00:03 | - |
| Netflix NIC IP | 192.168.4.1 | 3 |
| Netflix NIC MAC | 34:98:B5:00:00:04 | - |
