# Lab Week-08 Network Layer

## Objectives

* Demonstrate how to convert number between decimal, hex, and binary
* Demonstrate the application of Subnet Masks and CIDR blocks

### Questions

**Note** - you don't have to show work, and I know you can just type these conversions into Google, but I want to encourage you to do this on paper by hand -- so that these conversion get into your deep memory. They will come in handy some day.

1. Find the binary and hex value of the number 42
i)
2. Find the decimal of the binary 10101010
i)
3. Find the binary and hex value of the number 128
i)
4. Find the binary and hex value of the number 255
i)
5. What is the binary equivalent of the IP: 223.1.3.27?
i)
6. How many IP addresses are available in the CIDR block 64.131.110.0/24
i)
7. How many IP addresses are available in the CIDR block 64.131.110.0/23
i)
8. How many IP addresses are available in the CIDR block 10.0.0.0/8
i)
9. How many IP addresses are available in the CIDR block 172.16.0.0/16
i)
10. Why does a forwarding table have an *otherwise* entry?
i)

### Section 2 Questions

Consider a datagram network using 32-bit host addresses. Suppose a router  has four links, numbered 0 through 3, and packets are to be forwarded to the link interfaces as follows:  

| Destination Address | Link Interface |
| ----------------------------------- | - |
| 11100000 00000000 00000000 00000000 | 0 |
| 11100000 00111111 11111111 11111111 | - |
| 11100000 01000000 00000000 00000000 | 1 |
| 11100000 01000000 11111111 11111111 | - |
| 11100000 01000001 00000000 00000000 | 2 |
| 11100001 01111111 11111111 11111111 | - |
| otherwise | 3 |

Copy the table above and convert the binary to decimal, then instead of ranges, convert the forwarding table to be a prefix or CIDR block in the table below:

| Destination Address | Link Interface |
| ----------------------------------- | - |
| Prefix goes here | 0 |
| Prefix goes here | 1 |
| Prefix goes here | 2 |
| otherwise 	   | 3 |

Convert the following binary addresses and indicate which interface link they would used based on the forwarding table above in the Ordered list below.

* 11001000 10010001 01010001 01010101
* 11100001 01000000 11000011 00111100
* 11100001 10000000 00010001 01110111

* Converted IP
  * Interface number
* Converted IP
  * Interface number
* Converted IP
  * Interface number

Consider a subnet with prefix 128.119.40.128/26. Give an example of one  IP address (of form xxx.xxx.xxx.xxx) that can be assigned to this network.  
i)

Kurose, James F.; Ross, Keith. Computer Networking (p. 370). Pearson Education. Kindle Edition.
