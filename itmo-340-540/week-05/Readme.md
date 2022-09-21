# Review Questions

Week-05 Review questions covering Application Layer Protocols and their functions

## Objectives

* Explore and identify the aspects of Application Layer protocols, DNS, HTTP, and SMTP
* Identify how the Application Layer and the Transport Layer interact
* Explain and infer the meaning of packet captures in WireShark

## Questions

1. Suppose you wanted to do a transaction from a remote client to a server as  fast as possible. Would you use UDP or TCP? Why?  
i)
2. Recall that TCP can be enhanced with TLS to provide process-to-process  security services, including encryption. Does TLS operate at the transport  layer or the application layer? If the application developer wants TCP to be  enhanced with TLS, what does the developer have to do?  
i)
3. What is meant by a handshaking protocol?  
i)
4. Why do HTTP, SMTP, and IMAP run on top of TCP rather than on UDP?  
i)
5. Describe how Web caching can reduce the delay in receiving a requested  object. Will Web caching reduce the delay for all objects requested by a user  or for only some of the objects? Why?  
i)
6. What is the HOL blocking issue in HTTP/1.1? How does HTTP/2 attempt to  solve it?  
i)
7. True or False and why? A user requests a Web page that consists of some text and three images.  For this page, the client will send one request message and receive four  response messages.  
i)
8. True or False and why? Two distinct Web pages (for example, `www.mit.edu/research.html` and `www.mit.edu/students.html`) can be sent over the same persistent connection.  
i)
9. True or False and why? With non-persistent connections between browser and origin server, it is possible for a single TCP segment to carry two distinct HTTP request messages.  
i)
10. True or False and why? The `Date:` header in the HTTP response message indicates when the object in the response was last modified.  
i)
11. While running WireShark, open a browser and go to the URL [http://gaia.cs.umass.edu/](http://gaia.cs.umass.edu/ "http site"), note the **http**. Using the WireShark Capture, of that answer the following questions: What is the URL of the document requested by the browser?  
i)
12. What version of HTTP is the browser running?  
i)
13. Does the browser request a non-persistent or a persistent connection?  
i)
14. What is the IP address of the host on which the browser is running?  
i)
15. Obtain the HTTP/1.1 specification (RFC 2616 via a search engine). Answer the following questions:  Explain the mechanism used for signaling between the client and server to indicate that a persistent connection is being closed.
i)
16. Can the client, the server, or both signal the close of a connection?
i)
17. What encryption services are provided by HTTP?  
i)
18. Can a client open three or more simultaneous connections with a given server?  
i)
19. Either a server or a client may close a transport connection between them if either one detects the connection has been idle for some time. Is it possible that one side starts closing a connection while the other side is  transmitting data via this connection? Explain.
i)

## Deliverables

Place your answers to each question next to the *i)*. Copy this template into your own local private repo under the itmo-340 or itmo-540 folder. Create a subfolder called: `week-05` and place this document into that folder, push the code to GitHub and submit the URL to this document.

Kurose, James F.; Ross, Keith. Computer Networking (p. 166). Pearson Education. Kindle Edition.
