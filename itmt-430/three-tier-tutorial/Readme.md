# Tutorial for Constucting a Cloud Native Three Tier Application

This will be a combination lecture/tutorial on how and why we are creating a three-tier web application.

## Objectives

* Discuss the concept of the three-tier web application
* Explore the imperative nature of the three-tier application when dealing with cloud-native development
* Discuss tooling needed to create a three-tier application
* Discuss and explore the ramificaation of the modifications that modern operating systems require to become three-tier applications
* Discuss and explore the security ramifications of implementing a three-tier web applcation

## Outcomes

At the conclusion of this lecture/tutorial you will have explored the main tenants of a three-tier web applcation and the parameters and attributes required to construct one in a cloud-native manner.

## Purpose of an Application

When we look at a web application, we tend to look in the wrong way. When we 

## What is a Three-Tier Application?

![*Three-tier Application*](./images/three-tier.png "image of three tier application")

For this portion of the class, we will be migrating our application from a standard monolithic system into a three-tier application. The term `three-tier` is used in relation to how there are different levels of architecture when constructing an application in the cloud-native way.

* First Tier
  * Load-Balancer
* Second Tier
  * Front-end
  * Also known as the webserver tier
* Third Tier
  * Back-end
  * Also known as the database/datastore tier

### Load-Balancer

The `load-balancer` has the job of receiving requests 