# Lab Week-07 Transport Layer

## Objectives

* Explore and explain the nature of Transport Layer packet structures
* Explore and describe the fields of HTTP packets
* Explore and describe the fields of DNS packets

### Questions

1. Using the Wireshark capture from Blackboard, titled: `failed-dns-query.pcapng` Enter a filter for just `dns` packets. Looking at packet number 430:  in the Application layer, what is the content of the Queries field?  
i)
2. In packet number 431 there is a response.  Under the Flags field, in addition to the Response and 2 Recursion fields being set -- what other flag is set?  
i)
3. What is the outcome of packet 431?  
i)
4. Look at packet 447, what is the value in the UDP source port field and what is the value of the destination port field?  
i)
5. Open the packet capture: `second-http-with-fin.pcapng` Starting with packet 3.  What are the TCP flags set for packet 3,4, and 5. What is this exchange called?  
i)
6. Why does TCP do this?  
i)
7. Look at Packet 8 and 9 -- what is packet number 9's relationship to 8 (the numerical order is just a coincidence and not the answer)  
i)
8. Starting in Packet 7, after the 3 way handshake has been established, why is the TCP payload length 0 bytes in size?  
i)
9. Which TCP flag (or type) is sent back to acknowledge a SYN packet?  
i)
10. Starting at packet 30-32, what TCP flag is sent to signal the server side to begin to tear down the TCP connection?  
i)
11. Using the `TCP-seq-ack-example.xlsx` (Spreadsheet) and using the packet capture `second-http-with-fin.pcapng` -- fill out the columns of the entire http connection, from the initial three way handshake to the the three way tear down handshake. This will show you and end to end connection process for http over TCP to get a simple webpage. Save the modified spreadsheet into your github directory and commit to your repo along with the markdown files.
12. Using the packet capture `complete-tcp-large-image.pcapng`, this retrieves a simple webpage with a single image on it. Yet there are nearly 140 TCP segments captured (along with many ACKs) as part of the transfer of this webpage.  Compare this to the http request in the packet capture `second-http-with-fin.pcapng`, which retrieves a simple webpage with a single image and only has around 30 tcp segments transferred. Can you explain what each packet capture is requesting and why the number of tcp segments are different?  
i)
13. Using the packet capture `dns.npcapng` and a **dns** filter, starting from packet number 325 (look up for ucla.edu). Explain the presence or lack there of, a sequence number field in the UDP header.  
i)
14. List the 5 layers used in the network  
i)

## Deliverables

Place your answers to each question next to the *i)*. Copy this template into your own local private repo under the itmo-340 or itmo-540 folder. Create a subfolder called: `week-07` and place this document into that folder, push the code to GitHub and submit the URL to this document.
