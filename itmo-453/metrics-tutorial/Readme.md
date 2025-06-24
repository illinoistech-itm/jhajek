# Metrics Tutorial

This tutorial will explain how the metrics collection is setup for the VMs in our internal cloud.

## Metrics collection for Internal See-through Cloud

Each VM that is deployed on our internal cloud using the templates provided will be automatically configured for metrics export. Each VM will have Node Exporter configured for hardware metrics. The metrics will be harvested and amalgamated by a central Prometheus instance. A Grafana server will allow you to graph all your metrics. 

### Node Exporter

The Prometheus [Node Exporter](https://prometheus.io/docs/guides/node-exporter/ "webpage for installing Node Exporter") exposes a wide variety of hardware and kernel-related metrics.

* Exposed on 10.110.0.0/16 ens20 interface  
* On port 9100 on the meta-network

### Alert Manager

The [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/ "webpage for describing Alert Manager") handles alerts sent by client applications such as the Prometheus server. It takes care of deduplicating, grouping, and routing them to the correct receiver integration such as email, PagerDuty, or OpsGenie. It also takes care of silencing and inhibition of alerts.

### Prometheus 

[Prometheus](https://prometheus.io/docs/introduction/overview/ "webpage describing Prometheus") is an open-source systems monitoring and alerting toolkit originally built at SoundCloud. Since its inception in 2012, many companies and organizations have adopted Prometheus, and the project has a very active developer and user community. 

It is now a standalone open source project and maintained independently of any company. To emphasize this, and to clarify the project's governance structure, Prometheus joined the Cloud Native Computing Foundation in 2016 as the second hosted project, after Kubernetes.

Prometheus collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels.

### Grafana

In [Grafana](https://grafana.com/ "webpage for Grafana") you can query, visualize, alert on, and understand your data no matter where it’s stored. With Grafana you can create, explore, and share all of your data through beautiful, flexible dashboards.


