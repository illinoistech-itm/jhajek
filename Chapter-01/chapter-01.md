---
title: __Understanding the Technology and Philosophy of Linux__
  __Part II__
author: Jeremy Hajek
date: 01/05/2015
...

# Introduction to the Technology and Philosophy of Linux Part II

![*Understanding the Technology and Philosophy of Linux*](images/Chapter-Header/Chapter-01/cautionary.png "Understanding the Technology and Philosophy of Linux")

>  *"Linux is a complex example of the wisdom of crowds. It's a good example in the sense that it shows you can set people to work in a decentralized way - that is, without anyone really directing their efforts in a particular direction - and still trust that they're going to come up with good answers."*

*James Surowiecki*

## Introduction

  *"In my former book dear Theophilus..."* [^1]  This is the second book in the series of Understanding the Philosophy and Technology of Linux.  The first book sought to teach about the tooling and the reasons why those tools were created and for what purpose.  The second book now seeks to advance your tooling knowledge and bring you into the system adminstration arena--which focuses more on handling the applications and services that will run on those servers.   In the course of this chapter we need to indentify what are the right tools to complete that job.  We will begin with a review of Opensource and Free Software and then proceed to survey the types of operating systems available and their similarities and differences.
  
Why undertake another Linux book?  Isn't the world filed with enough documents and books?  On one hand you are correct there are many books in print and available.  Linux/Unix has a unique place in computing.  Entering now it's 4th decade of existance I believe we are facing a new dawn of the use of Linux.  Devices such as Android proliferating [1](http://www.cnet.com/news/android-dominates-81-percent-of-world-smartphone-market/) and companies such as RedHat being a billion dollar company [2](http://arstechnica.com/business/2012/02/how-red-hat-killed-its-core-productand-became-a-billion-dollar-business/).  Linux battles with its heritage of stemming from the Free Software movement of RMS and the OpenSource modern mission os the OSI.  Richard Stallman himself wrote a compelling article entitled ["Why Open Source misses the point of Free Software"](http://www.gnu.org/philosophy/open-source-misses-the-point.html).  

On the other hand you have the Debian [*"Civil War"*](http://debianfork.org/) in regards to Systemd and its integration, some would say take over of Linux.  Are the Devuan developers who split from Debian just nostalgists harkening for the halcyon days of early 2000's Linux wild west days?  Or do they have legitamite concerns (technical and ethical) about the direction of Linux?   

 It is in this background that this book is being generated.  There have been many fine books I have used over the years and have greatly benefitted from. Most of these books the content 80% is still valid-- vi is still vi right?  Only the desktop and package management has changed.  But the nature of development has changed.  Both Fedora and Ubuntu are on a six-month release cycle--making teaching about Linux features more difficult in a traditional book format.  ALso there are many quality distributions out there that we cannot cover them all.  A community effort is being constructed here so that anyone who can contribute material can do so freely via pull request or a fork with attribution.  

Seeing as this book focuses more on system administration we will focus mostly on "server" editions of Linux, such as RHEL, CENTOS, UBUNTU SERVER, FEDORA ATOM, and FREEBSD for comparison.  Since this book is being geared for use as a textbook, I wanted to include more than just exercises but background and context to the technologies being used.  I have included links to podcasts that I believe will be helpful in illuminating the background for the readers. 

The main focus is following the LPIC II exam structure plus additions owing to the nature of how technology is moving.  These chapter lists were compiled based on their exam objectives from 2013 plus updates in the area I personally believe are valuable to students based on industry experience gathered.

## Objectives

At the end of this book students/readers should be able to:

  * Administer a small to medium-sized site 
  * Plan, implement, maintain, keep consistent, secure, and troubleshoot a small mixed (MS, Linux) network, including a: 
  * LAN server (Samba, NFS, DNS, DHCP, client management)
  * Internet Gateway (firewall, VPN, SSH, web cache/proxy, mail)
  * Internet Server (web server and reverse proxy, FTP server)
  * Supervise assistants
  * Advise management on automation and purchases
  * Guidelines from [LPI II](https://www.lpi.org/certification/get-certified-lpi/lpic-2-linux-network-professional/) 
  * Add more as seen fit....
  
## Who should read it?

You should.  Any student or reader who has basic knowledge of Linux tools and the Unix philosophy.  If you are comfortable with commandline and can use a text editor, install packages and know the difference between Operating Systems then this book is for you.  This book will focus on three modules: 

  *  server operating sustems and tools
  *  server based applications and configuration
  *  server setup and deployment.

Each chapter has stated goals and objectives, followed by an introduction, followed by lecture material and references with examples followed by review questions and labs.  All content will be available on Github at the book's URL:  [https://github.com/jhajek/Linux-text-book-part-2](https://github.com/jhajek/Linux-text-book-part-2).

Information is in the [README.md](https://github.com/jhajek/Linux-text-book-part-2/blob/master/README.md) https://github.com/jhajek/Linux-text-book-part-2/blob/master/README.md contained in this project

## About the Author

My name is Enigo Montoya...

## Acknowledgements

Many people have helped me in the journey of learning technology -- more to fill out as I get closer to making this a reality.

Professor Sam Shamsuddin who taught me its not ee-tee-cee ef-es-tab but really ee-tee-cee ef-stab.

## Linux/Unix History and Philosophy (pulled from other book)

[See first book](https://github.com/jhajek/Linux-text-book-part-1)

## Environment setup for this book

This book assumes that you have access to a server edition of Linux.  I will be referencing instances using the VirtualBox Platform, but all of this work can be done on Hyper-V, VmWare, Parallels, or any other vm software you have, as well as AWS, Azure, Digital Ocean, Rackspace, or any other cloud service you can find (charges may apply).  Finally if you have an old PC laying around you can install these operating systems natively and all these exercises will work well.  

## Resources for you beyond this book  

  There are many resources out there on the internet.  You should go beyond expecting your instructor to tell you everything or expect that they are like Master Yoda and just dump all knowledge into you.  Though a professor or a mentor is a great place to start, you need to do some work finding communities and resources on the internet you can use to put yourself ahead of the competition.  Here is a short list that helped me greatly and are considered industry wide tools and communities you can participate in at any level.
  
### [Twit.tv](http://www.twit.tv) 

This is more than one site it's really the evolution of Television if you think about it.  

The site has a television like quality but all the shows are freely avaliable with archives.

+    [http://twit.tv/show/security-now](Security Now!)
+    [http://twit.tv/show/floss-weekly](FLOSS Weekly) 
+    [http://twit.tv/show/tri](Triangulation) 
  
### Stackoverlfow / Stackexchange

+    [http://stackoverflow.com](Stackoverflow)
+    [http://serverfault.com](Serverfault)
+    [http://superuser.com](SuperUser)
+    [http://askubuntu.com](Ask Ubuntu)
+    [https://ask.fedoraproject.org/en/questions/](Ask Feodra) -> Not a stackexchange site but a copy serving the same purpose

### [meetup.com](http://www.meetup.com) 
   
   Great way to find meetups in your local area. Usually sponsored at a corporate headquarters and a great way to meet people who are in the industry talking about things important to those that are hiring.  Great for students and others looking to learn beyond the class and make connections.

### Good old mailing lists

  Find your favorite Open Source project and join their mailing list and get a daily digest of the communication going on.  You can learn much just by being a reader.
   
## Microsoft Sway Presentations

Chapter 02 - [https://sway.com/M4f1DBSYxrW47eVb](https://sway.com/M4f1DBSYxrW47eVb "Chapter 2")
Chapter 03 - [https://sway.com/egsDPhcU1SVORziU](https://sway.com/egsDPhcU1SVORziU "Chapter 3")
Chapter 04 - [https://sway.com/J1Vb2xgB1IzlreVG](https://sway.com/J1Vb2xgB1IzlreVG "Chapter 4")
Chapter 05 - [https://sway.com/AeJeXAD4lmrAQAAH](https://sway.com/AeJeXAD4lmrAQAAH "Chapter 5")   
   
## Cover Image

[https://upload.wikimedia.org/wikipedia/commons/e/ea/Saint_Augustine_by_Philippe_de_Champaigne.jpg](https://upload.wikimedia.org/wikipedia/commons/e/ea/Saint_Augustine_by_Philippe_de_Champaigne.jpg)   
   
## Conclusion

You are ready to begin.  Hit Any Key to Continue...

[^1]: Acts of the Apostles 1:1 NIV 
