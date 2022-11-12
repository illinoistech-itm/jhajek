# Questions Week 11 Network Layer

## Objectives

* Display knowledge of configuring subnets and CIDR blocks
* Display and explain the IP packet's payload and header size relationship
* Examine Wireshark Captures and explain various field values and the concepts that generated those values
* Demonstrate the use of commandline tooling in relation to finding IP address values

### Questions

1. In general network packets are limited to 1,500 bytes due to the MTU (maximum transmission unit of the data-link layer). Assume a 20-byte IP header, how many datagrams would be required to send an JPG file of 3 million bytes? **Hint** - the answer is not 3,0000,000 / 1500 bytes. Take a look at the IPv4 diagram posted in Discord, *notes-resources*, and pay attention to the header size value for each packet in this calculation.  
i.

2. Using the subnet (CIDR block) of 223.1.1.0/23 - how many IP addresses do you have? **Hint** - remember the subtraction formula I showed.  
i.

3. Using the subnet (CIDR block) of 223.1.1.0/23. Can you create six more subnets: A-F and what would each CIDR block be if they contained the following number of IPs:  
i. Network A contains at least 250 addresses
i. Network B contains at least 122 addresses
i. Network C contains at least 16 addresses
i. Network D contains at least 4 addresses
i. Network E contains at least 30 addresses
i. Network F contains at least 4 addresses

4. Suppose an ISP owns the block of addresses of the form 223.1.1.64/26.  Suppose it wants to create four subnets from this block, with each block having the same number of IP addresses. What are the prefixes (of form a.b.c.d/x) for the four subnets? **Hint** start with how many IPs are in the subnet.  
i.

5. From the Discord channel - `Notes-Resources` channel, using the link from 10/20 to the IP address auction site, get the most recent price for these CIDR blocks: `/20 ARIN` and `/23 LACNIC`
i.

Open Wireshark: We will use the packet capture named: `dns.pcapng`. The packet capture, `dns.pcapng`, is a packet capture taken from a Windows desktop. We will be looking at DNS packets for the next few questions. Set a filter at the top of wireshark for `dns`. The traffic is the general background traffic happening on a Windows computer. There are many services in use and domain names being resolved.  

6. In packet 325 and 326 - both packets are DNS queries to resolve the hostname `http://www.ucla.edu`, in the packets, in the application layer DNS header, under the **Queries field**, one DNS record is of Type A and another of Type AAAA -- what do these values mean?  
i.

7. In packet 357 and 358 - what is the content of the Answer field?  And what are these?  
i.

8. In packet 496 - there is a DNS query for YouTube.  At the Network layer - what is the source IP and the destination IP?  
i.

9. In packet 496 - what version of IP is being used? Which field tells you this?  
i.

10. Using the `nslookup` tool from your computers commandline, find the all the IPv6 address for `netflix.com` -- list them here  
i.

11. Using the `ipconfig` or `ifconfig` (Windows or MacOS) find your wi-fi (or ethernet if you are using a wired connection) ipv6 address  
i.
