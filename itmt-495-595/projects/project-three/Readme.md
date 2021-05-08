# Project Two - Docker Compose

## Objectives

- Demonstrate the deployment of a 3 node Kubernetes cluster
- Demonstrate the difference between machine and container based applications
- Demonstrate the difference between machine based networking and container based cluster networking

## Outcomes

At the conclusion of this lab you will have successfully configured a 3 node Kubernetes cluster.  It will be configured and ready to deploy applications, as well as configure networking for external application access.

### Part I

Complete the Kubernetes install tutorial (same one we did in class) and demonstrate the correct installation and registration of all nodes.

Pace a screenshot of the output of the command: ```kubectl get nodes```

### Part II

Complete the tutorial, [Example: Deploying PHP Guestbook application with MongoDB](https://kubernetes.io/docs/tutorials/stateless-application/guestbook/ "Kubernetes tutorial")

Upon completion take a screenshot of these commands:

- `kubectl get pods`
- `kubectl get services`
- `kubectl get deployments`
- Under the step: **Viewing the Frontend Service via kubectl port-forward**
  - add a `--address` flag and place your vm0 public ip -- ex. 192.168.172.X
  - Place a screenshot of the application running in your browser

## Deliverables

 In your private GitHub repo, under your (itmt-495 or itmt-595) director, create a folder named: **project-three**.  Include this Readme.md file with the needed screenshots.
