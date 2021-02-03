# The Project

This is an eight node project.  

* Load Balancer
* Web Server 1
* Web Server 2
* Web Server 3
* Redis Caching Server
* MariaDB SQL Server Master
* MariaDB SQL Server Slave1
* MariaDB SQL Server Slave2

## How to use this repo

This will build the first 4 nodes and demonstrate a Hello World NodeJS app with Nginx load balancing built in

```bash
packer build --var-file=variables-lb.json ./ubuntu-lb-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws1-multi.json ; packer build --var-file=variables-ws ./ubuntu-ws2-multi.json ; packer build --var-file=variables-ws ./ubuntu-ws3-multi.json
```

```bash
packer build --var-file=variables-mm.json ./ubuntu-mm-multi.json ; packer build --var-file=variables-red.json ./ubuntu-redis-multi.json ; packer build --var-file=variables-ms.json ./ubuntu-ms1-multi.json ; packer build --var-file=variables-ms.json ./ubuntu-ms2-multi.json
```
