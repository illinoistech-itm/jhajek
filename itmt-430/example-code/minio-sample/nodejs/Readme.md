# Minio Configuration

This document covers the points required to deploy an Minio connection

### Packer Provisioner code to append secrets from Vault 

```bash
echo "DB_PASS='${DBPASS}'" >> /home/vagrant/team02m-2024/code/svelte/.env
echo "DB_USER='${DBUSER}'" >> /home/vagrant/team02m-2024/code/svelte/.env
echo "MINIO_ENDPOINT='${MINIOENDPOINT}'" >> /home/vagrant/team02m-2024/code/svelte/.env
echo "MINIO_ACCESS_KEY='${ACCESSKEY}'" >> /home/vagrant/team02m-2024/code/svelte/.env
echo "MINIO_SECRET_KEY='${SECRETKEY}'" >> /home/vagrant/team02m-2024/code/svelte/.env
echo "S3_BUCKET_NAME='${BUCKETNAME}'" >> /home/vagrant/team02m-2024/code/svelte/.env
```
