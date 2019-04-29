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

```bash
# script needed to import json files into mongodb to replicate
# https://stackoverflow.com/questions/19441228/insert-json-file-into-mongodb
mongoimport --db test --collection 1950 --jsonArray --file 1950.json --host 192.168.33.10
```
