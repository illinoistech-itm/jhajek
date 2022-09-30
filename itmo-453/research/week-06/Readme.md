# Homework for next week

* Validate that ws and db instances successfully cloned your GitHub repo
* Update Packer multi-build template for two additional server templates

## Riemann Packer Template

Riemann (event router)
Create shell script to install on Riemann only the Riemann software

```bash
# Steps needed to be included in install-riemann.sh 
sudo apt-get install -y openjdk-jre 
wget https://github.com/riemann/riemann/releases/download/0.3.8/riemann_0.3.8_all.deb
sudo dpkg -i riemann_0.3.8_all.deb
```

```bash
sudo systemctl enable riemann
```

## Grafana Packer Template

Grafana (graphing solution)

Create Shell script to install on Grafana server Grafana software

```bash
# Steps needed to be included in install-grafana.sh
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.1.6_amd64.deb
sudo dpkg -i grafana_9.1.6_amd64.deb
```

```bash
sudo systemctl enable grafana-server
```

## Telegraf

Telegraf hardware metrics collection tool

Add an additional shell script to deploy telegraf on every template (ws, db, riemann, and Grafana)

```bash
# Steps needed to be included in install-telegraf.sh
wget -q https://repos.influxdata.com/influxdb.key echo '23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key' | sha256sum -c && cat influxdb.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdb.gpg > /dev/null echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo apt-get update && sudo apt-get install -y telegraf
```

```bash
sudo systemctl enable telegraf
```

## Shell script to open firewall ports

* One shell script to open TCP 5555 for riemann
* One shell script to open TCP 3000 and TCP 8542 for Grafana

## Update Terraform

Update Terraform plan to deploy qty 1 of riemann vm and 1 of grafana and show your cloned repos
