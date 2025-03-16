# Sprint 03 Requirements and Deliverables

![*https://xkcd.com/303/*](./compiling.png "The life achievement you have unlocked...")

This document contains the Sprint-03 requirements and deliverables

## Objectives

* Create and Deploy a three tier web application
* Integrate and document aspects of the Three Ways into your development process
* Deploy your schema to a datastore for your application
* Create software deployment estimates to understand the nature of software production
* Engage and understand the process moving from design to prototype
* Discuss and deploy real-world security mitigations in your application
* Deploy two additional application features

## Outcomes

At the conclusion of this sprint project you will have built upon the work in Sprint-02. Your team will have deployed a working version of your site. You will begin to explore functionality and usability issues. Your team will be able to deploy a working project in an automated fashion for demonstration.

### Requirements

The list of requirements will be determined by your team and as part of the project management process. There will be a few additional items I will require and are listed below.

### Additional Readings and URLs

* [What is the difference between block, object, and file storage](https://aws.amazon.com/compare/the-difference-between-block-file-object-storage/ "webpage explaining the difference between block, object, and file storage." )
* [Minio Object Storage Platform](https://min.io/ "webpage for minio")

* [Minio Software Development Kits - SDK](https://min.io/docs/minio/linux/developers/python/API.htmlhttps://min.io/docs/minio/linux/developers/python/API.html "webpage for additional SDKs")
  * [Python](https://min.io/docs/minio/linux/developers/python/API.html "webpage for Python minio kit")
  * [JavaScript](https://min.io/docs/minio/linux/developers/minio-drivers.html#javascript-sdk "webpage for JavaScript Minio SDK")
* [Python Library for Hashicorp Vault - hvac](https://iit.instructure.com/courses/12200/modules/items/161775 "webpage for hvac library")
* JavaScript NPM modules for Vault integration
  * [hashi-vault-js](https://www.npmjs.com/package/hashi-vault-js "webpage for hashi-vault-js")
  * [node-vault](https://www.npmjs.com/package/node-vault "webpage for node-vault")
  * [vault-api](https://www.npmjs.com/package/vault-api ""webpage for vault-api)

* [Create Read Replicas for MySQL](https://dev.mysql.com/doc/refman/8.0/en/replication-setup-replicas.html "webpage to create read-replicas")

### Team Roles

Responsibility for team roles must be rotated immediately after sprint-02 is presented. Delaying this action cannot be used as an excuse for not delivering the required artifacts. This is an artificial inefficiency that I am introducing to allow all members to participate and experience each role.

* Project Manager
  * In charge of making sure that tasks are assigned, artifacts are being delivered, and project boards are updated accordingly.
  * Project manager must actively manage the project, you are not the passive receiver of information the night before
  * Must clearly document the state of the project at the start of the sprint so all of the work can be contrasted at the end
  * Project Manager must make a close recording of what has changed from sprint to sprint
  * Project Manager must also describe the task estimation process and describe what was completed and/or not completed
  * Must manage the team members and facilitate communication and individual progress outside of class times
* Developer 1 and 2
  * Programmers responsible for implementing code, coordinating with the UI/UX developers and IT Operations to deploy code.
  * Work with the developers to implement the designed UI/UX in code and CSS
  * Implementation must match the design showed in Sprint-01
  * UI/UX design is a complete master blueprint of what your finished site will look like
  * Help coordinate development into your team repo and using the provisioner scripts deploy your source code
* UI/UX 
  * Site testing
  * GitHub Issue and bug posting
* IT Orchestration and Security
  * Responsible for designing and deploying all virtualized infrastructure templates
  * Responsible for working with Developers to configure login authentication
  * Responsible for creating all secrets
    * These can be KV pair secrets
    * [AppRole Secrets](https://developer.hashicorp.com/vault/docs/auth/approle "webpage for App Role secrets")
    * [MySQL Secrets](https://developer.hashicorp.com/vault/docs/secrets/databases/mysql-maria "webpage for MySQL secret engine")
  * Responsible for working with the team to coordinate the automated building of the entire application
  * Responsible for creating any shell scripts required for automated deployment
  * Responsible for training and teaching internal group members for deployment of infrastructure
  * Responsible for noting and explaining all secrets management, firewall rules, and API security implemented

### Team Setup Items

In the team repo their will need to be a few additional folders added.

* A folder named: **code**
  * This will contain all application source code
* A folder named: **build**
  * This will contain all instructions on how to build and deploy your application
  * This will contain all Packer build templates
  * This will contain all Terraform plans
  * This will contain a `Readme.md` with detailed instruction on how to execute these scripts and a screenshot of what the finished artifact should look like - this is how you will know that you successfully deployed everything
* Repository should be clean -- remove uneeded files and place all files within the appropriately named directory

### Project Management Tool and Task Difficulty Estimation

One of the first steps the team will undertake is to determine which atomic tasks it will undertake from your project management tool. Note that some additional tasks (such as deploying infrastructure will have to be added to the Atomic Task list). We will work this sprint using a points estimation process -- this process is commonly used in industry to give an evolving estimate of software readiness and complexity. Your team will use a scale of 1-5 points. 5 being a hard task and 1 being a simple task. These numbers are purely relative to your own team's estimation of your own abilities. For Sprint 3 you will start with 25 total points of tasks to be assigned amongst the group members. If you finish them all, you can add increments of 15 points. If you don't finish them, as long as you are progressing, your team will reevaluate their numerical rankings of tasks in the next sprint.

In the Project Management tool the *25 points* worth of tasks need to have the point value assigned to that task and also have a name that is primary responsible and clearly marked.  This is how your Project Manager will report progress and how you will write your own and group critique at the end of the sprint.

**Note** -- this may require the group to *Swarm* on some initial items so that items that are blocking progress of the entire application don't hold up the entire team. Remember as a team-member it is your duty to swarm problems and solve them as a team (Third Way).

### Required Artifacts

The professor is prescribing a small number of **additional** required tasks to be selected amongst your 25 points. Each item listed here will contain multiple sub-steps. For instance deploying a database requires you to modify the database to listen for external connections, not on localhost.

* Login
  * Use a google account and Google OAuth for login authentication in your application code
* Infrastructure
  * Build each server template needed in the 3-tier app as Virtual Machines
  * Use assigned MAC address to get a static IP
  * Open proper firewall ports and firewall logic
* 3-Tier Application
  * First tier is a Load Balancer
    * Configure Loadbalancer to connect to webservers using the Consul DNS resolver on the meta-network (10.110.0.0/16)
    * Enable the use of a self-signed https TLS cert
    * Using Nginx and proper routes
    * Create packer VM templates on both SYSTEM41 and SYSETM42
  * Second tier is the webserver tier
    * Count of 3
    * Disable direct Public IP access to the 2nd and 3rd tier 
    * Connect to your database-tier using the Consul DNS resolver on the meta-network
    * Adjust links for images to use Minio (on-prem Object storage S3-like cluster)
      * Account credentials will be provided
      * [SDK for multi-language Minio access](https://min.io/docs/minio/linux/developers/minio-drivers.html "webpage for Minio SDK")
  * Third tier is a replicated database
    * Add a read-replica to your database tier
    * Configure database/datastore to listen for external connection of the meta-network (10.110.0.0/16)
    * Add **25** posts, 15 new posts and 10 replies - as according to your sites specific design
      * Essentially simulate real activity on your site
      * Use the [Python Faker](https://pypi.org/project/Faker/ "webpage for Python Faker") library to generate fake, but realistic names, states, cities, and so forth
* User Testing
  * Show use of GitHub Issues for placing tickets to fix bugs
  * UI/UX should be testing the production system, logging in, posting items, etc, etc.
  * Show all issues filed and corresponding GitHub artifact and note if it is fixed
* Deployment
  * All work needs to be tested and developed on the Proxmox Cloud Platform
     * You will have to build often as code changes
     * Expect 10+ deployments of your site (this is normative)
     * Development on Localhost is not acceptable at this point
     * Code will be pulled from GitHub and the system will be configured to start the application at boot
       * You can and will have to do some manual exploration, but back port those changes and always be able to build from scratch a fully working application
      * Reduce your Packer Template harddisk sizes to 15 GB (possibly 10) to reduce the raw copy time and then expand the disk size in the `remote-exec` portion of the `main.tf` (`lvextend` code is already there for you)
     * Removal of all hard coded secrets
     * Use Vault
       * These can be KV pair secrets
       * [AppRole Secrets](https://developer.hashicorp.com/vault/docs/auth/approle "webpage for App Role secrets")
       * [MySQL Secrets](https://developer.hashicorp.com/vault/docs/secrets/databases/mysql-maria "webpage for MySQL secret engine")
* Usage of site
  * Each team member demonstrate a successful login of a user and the equivalent of these actions per your site
    * Post a question
    * Answer a question
    * Logout that user
  * Will demonstrate your load balancer live by terminating 2 instances in succession

## Deliverables

* All sections presentation and critiques are due Monday March 31st at 10:00am.

### Individual Deliverables

The teamwork is cumulative but the grading is individual. Each team member will write a markdown based critique of their own work for the sprint and of their teammates' work. This will be anonymous and the purpose is to highlight good work and where improvement can be had, not to be punitive.

In the private repo provided to you (with your hawk ID), under the itmt-430 folder, create another folder that will be named for this sprint, **sprint-03**.  In this directory place a markdown based document named: **Report.md**

In the document **Report.md** include an H1 header called **Sprint-03** and then an H2 header: **Self-Critique** and detailing:

* In detail, explain your role for the sprint and the general area you covered
* Detail the tasks your were assigned and attach artifacts to show that they were completed (Kanban Cards, GitHub commits, screenshots of the application, etc. etc.) based on your story points
  * If your tasks were not able to be completed you need to detail the process you took and explain what happened to prevent your completion of assigned tasks
* Self-Critique what you did and what and note any areas of improvement

In the second part of the document, include and H2 header: **Group-Critique** and write a critique of the each team member:

* Explain each team-member's assigned role and what they were generally tasked to accomplish - using your project management board
* Explain which specific cards and tasks they were assigned and which they accomplished
  * If they were not able to accomplish their tasks give an explanation as to what happened
  * Make use of GitHub commits, the Project Management board or the Chat Channel to find supporting documents of your critique
* Give a general critique

#### Points for Self-Critique

The points for the critique items will break down as follows:

Topic | Points Range |
----------|------
Explain your role and general accomplishments | 3
Did the artifacts you submitted match the detailed tasks your were assigned?  | 3
Did your self-critique cover or mention any area of improvement? | 3
Was your markdown proper and well formed HTML when rendered? | 1

#### Points for Group Critique

The points for the critique items will break down as follows:

Topic | Points Range |
----------|------
Did you cover each team member's role and contributions? | 3
Did the artifacts each person submitted match what was assigned?| 3
Did your self-critique of the team members mention any areas of improvement? | 3
Was your markdown proper and well formed HTML when rendered? | 1

#### Rubric for Critiques

* 3 points meets expectations
* 2 points meets most of the items expected
* 1 point meets some of the items expected
* 0 points expectations missing

#### Points for Project Manager Presentation

The report will be worth 15 points and will be graded on a scale listed below.  In addition to the critique, the Project Manager must deliver the presentation and will be graded on a 15 point scale for items delivered and 5 points (2.5 points each for the self and group critique).

Topic | Points Range |
----------|------
Introduction of your teammates | 1
Clear introduction and small summary of what will be presented with a clear transition | 1
Demonstration of project management tool and explanation of the 25 build point items -- tell us what initially was assigned and what was accomplished | 3
Live Demonstrate components | 3
UI/UX walk through explaining what was accomplished and what portions of the UI/UX are outstanding | 3
Clear transition to a conclusion and small summary of presentation | 1

#### Rubric for Project Manager Presentation

* 3 points meets expectations
* 2 points meets most of the items expected
* 1 point meets some of the items expected
* 0 points expectations missing

### Presentation Requirements

* The presentation can be live or pre-recorded but only the Project Manager does the presenting
  * Others need to help prepare it but only the PM will do the presenting
  * Presentation is not a slide show, but a verbal explaining and demonstration of the artifacts produced
  * We need to see your face
  * If recorded, find a quiet place, focus on audio and or use head phones and make a quality recoding

### What to Deliver to Canvas

Each person must deliver the URL to their Critique reports at the beginning of Sprint Presentation Day, Monday 10 AM. In your private GitHub repo under `itmt-430` > `sprint-03` > `Readme.md`.

The project manager in addition has to submit a document under the `sprint-03` folder named `report.md` that is a written report collecting all of the artifacts presented in a single cohesive status report. This will count for 10 points of the PMs grade and is presented in markdown.

Feedback will be given on each submission.
