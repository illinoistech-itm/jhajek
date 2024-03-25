# Instructions to run the sample code

First setup two environment variables in the `.bashrc` file.  These credentials will be in a `.txt` file in your spark-edge server home directory.

```bash
export SECRETKEY=
export ACCESSKEY=
```

## Command to Execute

`spark-submit --master spark://sm.service.consul:7077 --packages org.apache.hadoop:hadoop-aws:3.2.3 minios3.py`

This will run your code on the spark cluster
