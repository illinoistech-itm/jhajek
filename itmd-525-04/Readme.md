# MongoDB relicate set and import of data

## Getting started

Prerequists are [Oracle Virtualbox](https://virutalbox.org "Install link for Virtual Box") and [Vagrant](https://vagrantup.com/download "Vagrant.com download link")

+ Clone this repo [https://github.com/illinoistech-itm/jhajek.git](https://github.com/illinoistech-itm/jhajek.git "Sample Mongodb code repo")
  + ```git clone https://github.com/illinoistech-itm/jhajek.git```
+ Change directory to the ```itmd-525-04``` directory
+ Run the script ```build-script.ps1``` if on Windows or ```build-script.sh``` if on Mac/Linux
+ Upon success you will be returned to the command prompt  ~~from each directory [xenial64-1,xenial64-2,xenial64-3,xenial64-4]  issue the command ```vagrant up``` from a different terminal window~~.  
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
+ Issue the command: ```mongod --bind_ip localhost,192.168.33.10 --replSet mdbDefGuide --dbpath ~/data/rs1 --port 27017 --smallfiles --oplogSize 200```
  + This is on page 213 of the pdf and 193 in the printed pages
+ You will get some warning message -- we will fix this shortly

+ Open a new console/terminal window
+ Change directory to the xenial64-2 directory
+ Issue a ```vagrant ssh``` command
  + You will now see a prompt: ```m2```
+ Issue the command: ```mongod --bind_ip localhost,192.168.33.11 --replSet mdbDefGuide --dbpath ~/data/rs2 --port 27017 --smallfiles --oplogSize 200```
  + This is on page 213 of the pdf and 193 in the printed pages
+ You will get some warning message -- we will fix this shortly

+ Open a new console/terminal window
+ Change directory to the xenial64-3 directory
+ Issue a ```vagrant ssh``` command
  + You will now see a prompt: ```m3```
+ Issue the command: ```mongod --bind_ip localhost,192.168.33.12 --replSet mdbDefGuide --dbpath ~/data/rs3 --port 27017 --smallfiles --oplogSize 200```
  + This is on page 213 of the pdf and 193 in the printed pages
+ You will get some warning message -- we will fix this shortly

+ Change directory to the xenial64-4 directory
+ Issue the command: ```vagrant ssh```
  + You will now see a prompt: ```m4```
+ Issue the comand: ```mongo 192.168.33.10```
  + We will make a connection to mongo from m1
  + At the mongodb prompt ">" issue the command from page 214/197:

```javascript

  > rsconf = {
       _id: "mdbDefGuide",
       members: [
           {_id: 0, host: "192.168.33.10:27017"},
           {_id: 1, host: "192.168.33.11:27017"},
           {_id: 2, host: "192.168.33.12:27017"}
           ]  
           }

```

```javascript

// or as a single line
> rsconf = { _id: "mdbDefGuide", members: [ {_id: 0, host: "192.168.33.10:27017"}, {_id: 1, host: "192.168.33.11:27017"}, {_id: 2, host: "192.168.33.12:27017"} ] }
```

```javascript

rs.initiate(rsconf)

```

+ This code will start the replicant set accross the 3 IPs
+ On each terminal concole you will see the warning message is gone.
+ If 192.168.33.10 is not the PRIMARY you can exit the connection and connect to the PRIMARY in the replica set
  + You can see the replica set status by issuing the command: ```rs.status()```

### Inserting data

+ To get started on page 217/197 there is some mongo code you can run to insert some dummy data while connected to the PRIMARY
+ This data will insert 1000 records and begin to replicate them accross the set (you will see debug info on the consoles)

```javascript
> use test
> for (i=0; i<1000; i++) {db.coll.insert({count: i})}  
> db.coll.count()
```

+ Exit from the mongo commandline: ">" back to the commandline
+ Run the line of code below, there is a sample json in the repo named s1950.json, p1950.json, and example2.json
  + This will insert 10 lines of JSON formated data from the NCDC government weather data center
  + s1950.json is just 10 records, single line format--not human readible
  + p1950.json is the same 10 records in human readible

```bash
# script needed to import json files into mongodb to replicate
# https://stackoverflow.com/questions/19441228/insert-json-file-into-mongodb
mongoimport --db test --collection employees --jsonArray --file example2.json --host 192.168.33.10

mongoimport --db test --collection s1950 --jsonArray --file s1950.json --host 192.168.33.10

mongoimport --db test --collection p1950 --jsonArray --file p1950.json --host 192.168.33.10
```

+ Reconnect to the mongodb cluster: from xenial64-4, "m4" by issuing the command: ```mongo 192.168.33.10```
+ From the mongo prompt: ">" issue the commands: ```db.employees.count()``` and ```db.1950.count()```
+ what are the results?
+ Issue this command:  ```db.employees.find({"FirstName": "Bruce"})```
+ Issue this command: ```db.1950.find({"wind_direction" : {"$gte" : 145)```
+ Issue the command to list all of the ```wind_direction``` values from the 1950 collection
+ Issue the command to list all of the ```airtemp``` values from the 1950 collection
+ Issue the command to list all of the ```atm_pressure``` values if they are not "99999" from the 1950 collection
+ Issue the commandto list all of the ```airtemp``` and ```qc4``` are of value 1, from the 1950 collection
+ To print out all of the Collections - issue the command: ```db.getCollectionNames()```