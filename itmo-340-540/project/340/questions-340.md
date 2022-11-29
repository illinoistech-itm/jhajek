# ITMO 340 Final Project Questions

## Background and Instructions

The purpose of this project is to see how a computer in a network gets internet access and is able to route between networks. We need to envision and understand the process packets take to communicate across the network. Ultimately the goal here is to describe the complete process to retrieve a sample webpage. We will be using snippets of real packet captures. You will be asked a series of questions and provided with information about the network and will have to fill in the values or explain basic concepts. We will assume that your computer is on a wired Ethernet connection for these questions and refer to the provided network diagram and the Readme.md file for network information.

There are 71 questions and or fill in the blanks (XXXs) to complete in this document. Each question or fill in the blank is worth 1 point.

### Retrieving an IP Address

You have just turned on your computer at the University. This is computer A in the ITM Network of the provided diagram. Your computer will use the DHCP protocol to try to retrieve an IP address for Computer A. Looking at the packet capture for the first step of the DHCP process (shown in packet capture below) and answer the following questions:

<pre>
Internet Protocol Version 4
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
    Total Length: 328
    Identification: 0xddc4 (56772)
    Flags: 0x00
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 128
    Protocol: UDP (17)
    Header Checksum: 0x0000 [validation disabled]
    Source Address: XXX.XXX.XXX.XXX
    Destination Address: XXX.XXX.XXX.XXX
</pre>

1. What is the first phase of the DHCP process?  
i.
1. What would be the source IP in the Network layer of this packet?  
i.
1. Explain your previous answer.  
i.
1. What is the destination IP address in the Network Layer of this packet?  
i.
1. Explain your previous answer.  
i.

This is a DHCP Discover phase packet being sent from Computer A, replace the occurrence of XXX with their proper values (1 line in all).

<pre>
Dynamic Host Configuration Protocol (Discover)
    Option: (53) DHCP Message Type (Discover)
        Length: 1
        DHCP: Discover (1)
    Option: (61) Client identifier
        Length: 7
        Hardware type: Ethernet (0x01)
        Client MAC address: XXX.XXX.XXX.XXX
    Option: (50) Requested IP Address
        Length: 4
        Requested IP Address: 192.168.1.10  <-- take note of this IP address, you will need it in later DHCP phases.
</pre>

When answering a DHCP Discover packet, a response is sent from the DHCP server. Answer the following questions and fill in the information replacing the XXXs where you see the (5 lines in all).

1. T/F Correct if false, the DHCP Offer packet offers an IP address to the requesting computer  
i.

<pre>
Dynamic Host Configuration Protocol (Offer)
    Option: (53) DHCP Message Type (Offer)
        Length: 1
        DHCP: Offer (2)
    Option: (61) Client identifier
        Length: 7
        Hardware type: Ethernet (0x01)
        Client MAC address: XXXXXXXXXXXXXXXXXXX
    Option: (54) DHCP Server Identifier
        Length: 4
        DHCP Server Identifier: XXX.XXX.XXX.XXX
    Option: (51) IP Address Lease Time
        Length: 4
        IP Address Lease Time: (86400s) 1 day
    Option: (58) Renewal Time Value
        Length: 4
        Renewal Time Value: (43200s) 12 hours
    Option: (59) Rebinding Time Value
        Length: 4
        Rebinding Time Value: (75600s) 21 hours
    Option: (6) Domain Name Server
        Length: 4
        Domain Name Server: XXX.XXX.XXX.XXX
    Option: (3) Router
        Length: 4
        Router: XXX.XXX.XXX.XXX
    Option: (1) Subnet Mask
        Length: 4
        Subnet Mask: XXX.XXX.XXX.XXX
    Option: (2) Time Offset
        Length: 4
        Time Offset: (-21600s) -6 hours
    Option: (255) End
        Option End: 255
</pre>

When answering a DHCP Offer packet, the requestor can make a specific request for a preferred IP address (usually the one it had last time it was on the network). Reference the DHCP Discover Packet trace above for the requested IP address. Fill in the information replacing the XXXs where you see the (3 lines in all).

<pre>
Dynamic Host Configuration Protocol (Request)
    Option: (53) DHCP Message Type
        Length: 1
        DHCP: Request (3)
    Option: (61) Client identifier
        Length: 7
        Hardware type: Ethernet (0x01)
        Client MAC address: XX:XX:XX:XX:XX:XX
    Option: (50) Requested IP Address
        Length: 4
        Requested IP Address: XXX.XXX.XXX.XXX
    Option: (54) DHCP Server Identifier
        Length: 4
        DHCP Server Identifier: XXX.XXX.XXX.XXX
    Option: (12) Host Name
        Length: 13
        Host Name: lenovo-laptop
</pre>

The final phase of the DHCP negotiation is the DHCP ACK. Answer the following questions and fill in the information replacing the XXXs where you see the (5 lines in all).

1. How many phases of the process to request and IP address via the DHCP protocol?  
i.
1. T/F Correct if false. DHCP is a link-layer protocol  
i.
1. Who sends the DHCP ACK packet, the DHCP server or the computer requesting the DHCP address?  
i.  

<pre>
Dynamic Host Configuration Protocol (ACK)
    Option: (53) DHCP Message Type
        Length: 1
        DHCP: ACK (5)
    Option: (61) Client identifier
        Length: 7
        Hardware type: Ethernet (0x01)
        Client MAC address: XX:XX:XX:XX:XX:XX
    Option: (54) DHCP Server Identifier
        Length: 4
        DHCP Server Identifier: XXX.XXX.XXX.XXX
    Option: (51) IP Address Lease Time
        Length: 4
        IP Address Lease Time: (86400s) 1 day
    Option: (58) Renewal Time Value
        Length: 4
        Renewal Time Value: (43200s) 12 hours
    Option: (59) Rebinding Time Value
        Length: 4
        Rebinding Time Value: (75600s) 21 hours
    Option: (6) Domain Name Server
        Length: 4
        Domain Name Server: XXX.XXX.XXX.XXX
    Option: (3) Router
        Length: 4
        Router: XXX.XXX.XXX.XXX
    Option: (1) Subnet Mask
        Length: 4
        Subnet Mask: XXX.XXX.XXX.XXX
</pre>

Complete this table with the values that the DHCP server has provided to Computer A in the previous traces (4 XXXs in all).

Computer A
| Field | Value |
| -- | ------|
| IP Address | XXX.XXX.XXX.XXX |
| Subnet | XXX.XXX.XXX.XXX |
| Default Gateway | XXX.XXX.XXX.XXX |
| DNS Server | XXX.XXX.XXX.XXX |
| MAC Address | B4:74:9F:88:4E:43 |

### Link Layer Communication

Once you have retrieved an IP address via the DHCP process, now you can communicate with computers on the network. Let us try to connect Computer A and Computer B over the network to see if Computer B is on the network and responding to network traffic. Answer the following questions and fill in the replace the XXXs with the values requested (2 in all).

<pre>
Internet Protocol Version 4,
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
    Total Length: 60
    Identification: 0x83c3 (33731)
    Flags: 0x00
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 128
    Protocol: ICMP (1)
    Header Checksum: 0x0000 [validation disabled]
    Source Address: XXX.XXX.XXX.XXX
    Destination Address: XXX.XXX.XXX.XXX
</pre>

1. What would be the command line tool used to see if Computer B is responding to network traffic?  
i.
1. What is the protocol this tool uses?  
i.
1. Briefly explain the purpose of the ARP protocol.  
i.
1. What layer of the 5 Layer Network Model does this protocol work at (hint it is a LAN protocol)?  
i.
1. Fill in the blank: Looking at the ARP (Address Resolution Protocol) protocol, it is used at the _____________ layer for resolving IP addresses to MAC addresses.  
i.

Looking at this ARP Packet trace that was sent from Computer B to Computer A, what would be the values placed in the XXX place-holders (2 in all).

<pre>
Address Resolution Protocol (reply)
    Hardware type: Ethernet (1)
    Protocol type: IPv4 (0x0800)
    Hardware size: 6
    Protocol size: 4
    Opcode: reply (2)
    Sender MAC address: XX:XX:XX:XX:XX:XX
    Sender IP address: XXX.XXX.XXX.XXX
    Target MAC address: B4:74:9F:88:4E:43
    Target IP address: 192.168.1.10
</pre>

### HTTP Traffic

Assume Computer B has an HTTP server. From Computer A assume you open a web browser and make a request to http://192.168.1.11. Answer the following questions and fill in the XXXs with the proper values (3 in all).

<pre>
Internet Protocol Version 4
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
    Total Length: 430
    Identification: 0xa51f (42271)
    Flags: 0x40, Don't fragment
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 128
    Protocol: TCP (6)
    Header Checksum: 0x90c5 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: XXX.XXX.XXX.XXX
    Destination Address: XXX.XXX.XXX.XXX
</pre>

<pre>
Transmission Control Protocol
    Source Port: 13310
    Destination Port: XX
</pre>

1. What layer of the 5 layer network model is the HTTP protocol at?  
i.
1. T/F Correct if false, HTTP provides encryption as part of its protocol.  
i.
1. T/F Correct if false, DNS is a transport layer protocol.  
i.
1. Briefly explain the difference between TCP and UDP  
i.
1. Briefly explain the concept of Sequence Numbers and Acknowledgement numbers is TCP.  
i.
1. What is the default port that HTTP listens on?  
i.
1. What is the 4th layer of the 5 layer network model?  
i.
1. What transport layer protocol is this request using?  
i.
1. What is the name for the first three TCP packets that are exchanged before an HTTP connection is made.  
i.

Now we will take a look at the HTTP protocol content to discover what our request is trying to accomplish. Using this WireShark capture of the HTTP connection between Computer A and Computer B:

<pre>
Hypertext Transfer Protocol
    GET / HTTP/1.1\r\n
      Request Method: GET
      Request URI: /
      Request Version: HTTP/1.1
    Host: 192.168.1.11\r\n
    User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:107.0) Gecko/20100101 Firefox/107.0\r\n
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8\r\n
    Accept-Language: en-US,en;q=0.5\r\n
    Accept-Encoding: gzip, deflate\r\n
    Connection: keep-alive\r\n
    Upgrade-Insecure-Requests: 1\r\n
    Pragma: no-cache\r\n
    Cache-Control: no-cache\r\n
</pre>

1. List the HTTP version  
i.
1. List the HTTP method  
i.
1. List the Request URI  
i.

Answer the following questions based on the response to this HTTP request:

<pre>
Hypertext Transfer Protocol
    HTTP/1.1 200 OK\r\n
        Response Version: HTTP/1.1
        Status Code: 200
        Response Phrase: OK
    Date: Sun, 27 Nov 2022 03:23:20 GMT\r\n
    Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips PHP/7.4.30 mod_perl/2.0.11 Perl/v5.16.3\r\n
    Last-Modified: Tue, 01 Mar 2016 18:57:50 GMT\r\n
    ETag: "a5b-52d015789ee9e"\r\n
    Accept-Ranges: bytes\r\n
    Content-Length: 2651\r\n
    Keep-Alive: timeout=5, max=100\r\n
    Connection: Keep-Alive\r\n
    Content-Type: text/html; charset=UTF-8\r\n
</pre>

1. What is the Status Code and what does this mean in regards to the request?  
i.

### Understanding Routing of Packets

Based on the three networks detailed - create a forwarding table that includes prefix and output port by updating the table below - use the information from the Readme.md file for reference. Add your values to the chart below.

| Network Prefix | Output Port |
| -------------- | ----------- |
| - | - |
| - | - |
| - | - |

In the Computer Science Network, 192.168.2.2 is running a webserver. If you make an HTTP request from Computer A in the ITM network to Computer B on the CS network:

1. Which Output Port Interface will your packet be forwarded to?  
i.
1. For the TCP packet returning the ACK from Computer B to Computer A, which Output Port Interface will your packet be forwarded to?  
i.
1. A HTTP request is sent from Computer A in the ITM network, for the IP address of 192.168.5.5. When this packet hits the router - explain what will happen?  
i.
1. When a packet reaches the router and the TTL is at 0, explain what will the router do with that packet.  
i.
1. In this example network are we using Classical Routing or Software Defined Networking?  
i.
1. Software Defined Networking can route based on fields in three layers, list these three layers and the 11 fields possible.  
i.
1. Briefly explain why SDN violates the Classical Routing model.  
i.
1. Briefly explain the difference between a switch and a router (assume the classical model).  
i.
1. Briefly explain the concept of a subnet.  
i.

### DNS Resolution

Looking at the snippets of these two DNS packet queries (DNS query and DNS response) replace the values.  Computer A is making an http GET request to http://fusion.cs.iit.edu. Fill in the XXXs with the information contained in the A record -- see the Readme.md for details.

<pre>
Domain Name System (query)
    Transaction ID: 0x0002
    Flags: 0x0100 Standard query
    Questions: 1
    Answer RRs: 0
    Authority RRs: 0
    Additional RRs: 0
    Queries
        XXXXXXXXXXXXXXXXXXXXXXXX: type A, class IN
</pre>

<pre>
Domain Name System (response)
    Transaction ID: 0x0300
    Flags: 0x8180 Standard query response, No error
    Questions: 1
    Answer RRs: 1
    Authority RRs: 0
    Additional RRs: 0
    Queries
    Answers
        XXXXXXXXXXXXXXXXXX: type A, class IN, addr XXX.XXX.XXX.XXX
</pre>

Looking at the DNS packet (query) from Computer A in the ITM Network and the DNS server in the Applied Math Network, fill in the XXX with their appropriate values at the Network Layer

<pre>
Internet Protocol Version 4
    Source Address: XXX.XXX.XXX.XXX
    Destination Address: XXX.XXX.XXX.XXX
</pre>

Looking at the DNS packet (query) from Computer A in the ITM Network and the DNS server in the Applied Math Network, fill in the XXX with their appropriate values at the Transport Layer

<pre>
User Datagram Protocol
    Source Port: 61833
    Destination Port: XX
    Length: 131
</pre>

## Deliverable

Create a folder named **project** under the provided GitHub repo under the **itmo-340** directory. Push the questions.md to this folder with the answers completely filled out - submit the URL to this document in Blackboard by Wednesday December 3rd 6:25 PM CST (Chicago Time).
