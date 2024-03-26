# Instructions to run the sample code

Initial steps to connect to the Spark Cluster...

* Connect the school VPN
* Connect via SSH
  * This is the example syntax
  * `ssh -i "~\.ssh\id_ed25519_spark_edge_key" hajek@system26.rice.iit.edu`
* Setup two environment variables in the `.bashrc` file. 
  * These credentials will be in a file named `cred.txt` located in your spark-edge server home directory
  * Add these two values to the end of `.bashrc`
  * The `SECRETKEY` is the value in front of the `,` and the `ACCESSKEY` is the part after the `,`

```bash
export SECRETKEY=
export ACCESSKEY=
```

* Source the the `.bashrc` file by typing type the command: `. ~/.bashrc`

## Command to Execute

`spark-submit --master spark://sm.service.consul:7077 --packages org.apache.hadoop:hadoop-aws:3.2.3 minios3.py`

This will run your code on the spark cluster
