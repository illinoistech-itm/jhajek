# Assignment-02 Deliverable

## Part-01

Connect to the three Kubernetes nodes provided to you and configure a 3 node (1 master 2 node) Kubernetes Cluster.    Configure a client system to remotely connect to the cluster (copy .kube/config).

### Deliverable

Create a folder named **Assignment-02** under your itmt-595 folder in your private GitHub repo provided for the class.  Include a working example of your docker-compose.yaml converted into a Kubernetes Manifest(s).  Provide the manifest files, your .kube/config file (so I can connect to your cluster), and a ReadMe.md file with any instructions or assumptions needed to run the project.

In the manifest, specifify make the same functionality from the docker-compose.yaml file in the manifest file.
Include these additional features.

* Add a quota for each container to use .25 of the processor 
* And have a quota of 1 GB of ram per container
* convert docker-compose to a ReplicaSet manifest (reuse from previous step) with nginx having replica value at 3

*All work is due by the end of the semester Saturday July 27th 11:59 pm*

Submit the URL to your GitHub repo in Blackboard