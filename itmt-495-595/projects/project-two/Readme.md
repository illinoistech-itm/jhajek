# Project Two - Docker Compose

## Objectives

- Demonstrate declarative programming model using Docker and Docker Compose to construct an application
- Demonstrate creation of immutable infrastructure

## Outcomes

At the conclusion of this lab, you will have successfully deployed a 5 node application via a virtualization platform.  Demonstrating the concept of building immutable infrastructure.  

`docker-compose.yml` includes 5 nodes

- lb Nginx loadbalancer
- ws1 nodejs webserver
  - create a Dockerfile to build and include an application
  - node:lts-buster
- ws2 nodejs webserver
  - create a Dockerfile to build and include an application
  - node:lts-buster
- ws3 nodejs webserver
  - create a Dockerfile to build and include an application
  - node:lts-buster
- db MySQL database 5.7
  - Use ENTRYPOINT to run sql statements at first start

- Create two networks and attach the appropriate containers
  - frontend
  - backend

- Create a local volume mount for the MySQL database partition: `/var/lib/mysql`

### Installation instructions

Mention any instructions needed to run your code to produce the functioning WordPress application

## Deliverables

 In your private GitHub repo, under your (itmt-495 or itmt-595) director, create a folder named: **project-two**.  Inside this folder place all code needed to run the virtualization project and display the load balancing output.
