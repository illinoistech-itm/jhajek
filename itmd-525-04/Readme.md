# MongoDB relicate set and import of data

## Getting started

Prerequists are [Oracle Virtualbox](https://virutalbox.org "Install link for Virtual Box") and [Vagrant](https://vagrantup.com/download "Vagrant.com download link")

+ Run the script ```build-script.ps1``` if on Windows or ```build-script.sh``` if on Mac/Linux+
+ Upon succes - from each directory [xenial64-1,xenial64-2,xenial64-3,xenial64-4]  issue the command ```vagrant up``` from a different terminal window.  
  + This will start 3 instances of Mongodb and a fourth for management and remote connections.
+ All 4 instances will be running on a Virtualbox private internal network so you can access these systems anywhere.
  + ```xenial64-1 192.168.33.10```
  + ```xenial64-2 192.168.33.11```
  + ```xenial64-3 192.168.33.12```
  + ```xenial64-4 192.168.33.13```

### Connecting and setting up the replicant set

+ Open a new console/terminal window
+ Change directory to the xenial64-1 directory
+ Issue a ```vagrant ssh``` command
  + You will now see a prompt: ```m1```
+ Issue the command: ```mongod --bind_ip localhost,192.169.33.10 --replSet mdbDefGuide --dbpath ~/data/rs1 --port 27017 --smallfiles --oplogSize 200```
  + This is on page 213 of the pdf and 193 in the printed pages
+ You will get some warning message -- we will fix this shortly

+ Open a new console/terminal window
+ Change directory to the xenial64-2 directory
+ Issue a ```vagrant ssh``` command
  + You will now see a prompt: ```m2```
+ Issue the command: ```mongod --bind_ip localhost,192.169.33.11 --replSet mdbDefGuide --dbpath ~/data/rs2 --port 27017 --smallfiles --oplogSize 200```
  + This is on page 213 of the pdf and 193 in the printed pages
+ You will get some warning message -- we will fix this shortly

+ Open a new console/terminal window
+ Change directory to the xenial64-3 directory
+ Issue a ```vagrant ssh``` command
  + You will now see a prompt: ```m3```
+ Issue the command: ```mongod --bind_ip localhost,192.169.33.12 --replSet mdbDefGuide --dbpath ~/data/rs3 --port 27017 --smallfiles --oplogSize 200```
  + This is on page 213 of the pdf and 193 in the printed pages
+ You will get some warning message -- we will fix this shortly

+ Change directory to the xenial64-4 directory
+ Issue the command: ```vagrant ssh```
  + You will now see a prompt: ```m4```
+ Issue the comand: ```mongo 192.168.33.10```
  + We will make a connection to mongo from m1
  + At the mongodb prompt ">" issue the command:

```javascript

   rsconf = {
       _id: "mdbDefGuide",
       members: [
           {_id: 0, host: "192.168.33.10:27017"},
           {_id: 1, host: "192.168.33.11:27017"},
           {_id: 2, host: "192.168.33.12:27017"}
           ]  
           }

```

```javascript

rs.initaite()

```

+ This code will start the replicant set accross the 3 IPs
+ On each terminal concole you will see the warning message is gone.
+ If 192.168.33.10 is not the primary you can exit the connection and connect to the primary in the replicant set
  + you can see the replicant set status by issuing the command: ```rs.status()```

### Inserting data

+ Clone this repo [https://github.com/illinoistech-itm/jhajek.git](https://github.com/illinoistech-itm/jhajek.git "Sample Mongodb code repo")
  + ```git clone https://github.com/illinoistech-itm/jhajek.git```
+ Change directory to the ```itmd-525-04``` directory  


```bash
# script needed to import json files into mongodb to replicate
# https://stackoverflow.com/questions/19441228/insert-json-file-into-mongodb
mongoimport --db test --collection 1950 --jsonArray --file 1950.json --host 192.168.33.10
```
