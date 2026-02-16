# Sprint 02 Requirements and Deliverables

This document contains the `Sprint-02` requirements and deliverables.

## Objectives

* Implement Secret Management using Vault
* Create a virtualized environment for your 3-tier application
* Deploy a three-tier web application in production
* Integrate and document aspects of the Three Ways into your development process
* Deploy your schema to a datastore for your application
* Enable and create software deployment estimates to understand the nature of software production
* Engage and understand the process moving from design in to an initial prototype
* Discuss and deploy real-world security mitigations in your application

## Outcomes

At the conclusion of this sprint you will have worked in combination with your teammates to estimate the timing to deliver software artifacts. You will have deployed your virtualized 3-tier application, applying your UI/UX design you created in `sprint-01`. You will have integrated your Schema into your datastore as well as addressed security concerns and have begun to assign and complete tasks you were assigned. Your goal is to show a working application and login at the end of `sprint-02`.

### Requirements

There will be a long list of requirements. This will be a longer than usual sprint to make sure we have time to step through each of these steps and lay the ground work for our application. Each team member will be responsible for demonstrating the state of the project at the end of the sprint and the Project Manager will need to keep careful track of all the progress made. The amount of the project to be finished will be determined by your team (with a few global items assigned by the professor).

### Team Roles

For this sprint, the roles are not exclusive. Anyone can submit code for instance. The roles must rotate per sprint. This is an artificial inefficiency that I am introducing to allow all members to participate and experience each role.

* Project Manager
  * In charge of making sure that tasks are assigned, artifacts are being delivered, and project boards are updated accordingly.
  * Must clearly document the state of the project at the start of the sprint so all of the work can be contrasted at the end
  * Project Manager must take close notes of what has changed from sprint to sprint
  * Project Manager must also describe the task estimation process and describe what was completed and/or not completed
  * Must manage the team members and facilitate communication and individual progress outside of class times
* Developer 1 and 2
  * Responsible for deciding on a programming language framework used, any APIs that will be created, and if any frameworks are implemented
  * Need to investigate integrating Oauth2 and Using Google for 3rd party auth (log in with Google)
  * Once this is chosen -- it is locked in for the rest of the class
  * Language must have a package manager
  * Use of Firebase is **not** allowed for this project (it is a great product though)
  * Use of raw PHP is not allowed
  * Must begin to code and deploy the items decided upon by the Project Manager
* UI/UX
  * Work with the developers to implement the designed UI/UX in code and css
  * Implementation must match the design
  * If your UI/UX design is incomplete need to complete it before any work can progress
  * UI/UX design is a complete master blueprint of what your finished site will look like
* IT Orchestration and Security
  * Responsible for designing and deploying all virtualized infrastructure templates (Terraform and Packer)
  * Responsible for working with Developers to configure login authentication
  * Responsible for working with the team to coordinate the automated building of the entire application
  * Responsible for creating any shell scripts required for automated deployment
  * Responsible for training and teaching internal group members for deployment of infrastructure
  * Responsible for implementing Ubuntu Server 24.04
  * Responsible for noting and explaining all secrets management, firewall rules, and API security implemented

### Team Setup Items

In the team repo their will need to be a few additional folders added.

* A folder named: **code**
  * This will contain all application source code
* A folder named: **build**
  * This will contain all instructions on how to build and deploy your application
  * This will contain Packer build templates for building Virtual Machines
  * The build directory will contain a `Readme.md` with detailed instruction on how to execute these scripts

### Project Management Tool and Task Difficulty Estimation

One of the first steps the team will undertake is to determine which atomic tasks it will undertake from your project management tool. Note that some additional tasks (such as deploying infrastructure will have to be added to the Atomic Task list). We will work this sprint using a points estimation process -- this process is commonly used in industry to give an evolving estimate of software readiness and complexity. 

Your team will use a scale of 1-5 points per task; 5 being a hard task and 1 being a simple task. These numbers are purely relative to your own team's estimation of your own abilities. For Sprint 2 you will start with 25 total points of tasks to be assigned amongst the group members. If you finish them all, you can add increments of 15 points. If you don't finish them, as long as you are progressing, your team will reevaluate their numerical rankings of tasks in the next sprint.

In the Project Management tool the **25 points** worth of tasks need to have the point value assigned to that task and also have a name that is primary responsible and clearly marked. This is how your Project Manager will report progress and how you will write your own and group critique at the end of the sprint. The professor will check in weekly during the beginning of the Lab days to check the current progress and help coordinate in anyway.  

**Note** -- this may require the group to *Swarm* on some initial items so that items that are blocking progress of the entire application don't hold up the entire team. Remember as a team-member it is your duty to swarm problems and solve them as a team (The Third Way).

### Required Artifacts

The professor is prescribing a small number of **additional** required tasks to be selected amongst your 25 points

* Login
  * Use Google OAuth for login authentication in your application code (there are other options -- check with the instructor for approval first)
  * Rolling your own Authentication system in 2026 is not a valid choice
* Choice of Server OS
  * Ubuntu Server 24.04
* Infrastructure
  * Build virtual machine templates of each system you will need in the 3-tier app as Virtual Machines using [Packer](https://packer.io "webpage for hashicorp packer")
  * Use of [Terraform](https://www.terraform.io/ "webpage for hashicorp terraform") for deploying virtual machine templates
* You will be assigned API keys and access to the department infrastructure
  * [Proxmox Cloud Platform Cluster](https://proxmox.com "webpage for proxmox virtualization platform")
* Your team will be assigned a Mac address and a static IP for their load-balancer

### Team Static DHCP IPs

| Team Number | MacAddr | Static IP | FQDN |
| ----------- | -------------| ------------- | ----------------- |  
| team00 | bc:24:11:00:00:1A | 192.168.192.114 | system22h114.itm.iit.edu
| sp2026-team01	| bc:24:11:00:00:1B	| 192.168.192.115	| system22h115.itm.iit.edu
| sp2026-team02	| bc:24:11:00:00:1C	| 192.168.192.116	| system22h116.itm.iit.edu
| sp2026-team03	| bc:24:11:00:00:1D	| 192.168.192.117	| system22h117.itm.iit.edu
| sp2026-team04	| bc:24:11:00:00:1E	| 192.168.192.118	| system22h118.itm.iit.edu
| sp2026-team05	| bc:24:11:00:00:1F	| 192.168.192.119	| stem22h119.itm.iit.edu
| sp2026-team06	| bc:24:11:00:00:20	| 192.168.192.120	| system22h120.itm.iit.edu
| sp2026-team07	| bc:24:11:00:00:21	| 192.168.192.121	| system22h121.itm.iit.edu
| sp2026-team08	| bc:24:11:00:00:22	| 192.168.192.122	| system22h122.itm.iit.edu
| sp2026-team09	| bc:24:11:00:00:23	| 192.168.192.123	| system22h123.itm.iit.edu
| sp2026-team10	| bc:24:11:00:00:24 | 192.168.192.124	| system22h124.itm.iit.edu
| sp2026-team11	| bc:24:11:00:00:25	| 192.168.192.125	| system22h125.itm.iit.edu
| sp2026-team12	| bc:24:11:00:00:26	| 192.168.192.126	| system22h126.itm.iit.edu

## Deliverables

* All presentations and critiques are due 10:00am March 3rd

### Individual Deliverables

The teamwork is cumulative but the grading is individual. Each team member will write a markdown based critique of their own work for the sprint and of their teammates' work.  This will be anonymous and the purpose is to highlight good work and where improvement can be had, not to be punitive.

In the private repo provided to you (with your hawk ID), under the `itmt-430` folder, create another folder that will be named for this sprint, `sprint-02`.  In this directory place a markdown based document named: `Readme.md`. 

In the document `Readme.md` include an H1 header called `Sprint-02` and then an H2 header: `Self-Critique` and detailing:

* In detail, explain your role for the sprint and the general area you covered
* Detail the tasks your were assigned and attach artifacts to show that they were completed (Kanban Cards, GitHub commits, screenshots of the application, etc. etc.)
  * If your tasks were not able to be completed you need to detail the process you took and explain what happened to prevent your completion of assigned tasks
* Self-Critique what you did and what and note any areas of improvement

In the second part of the document, include and H2 header: **Group-Critique** and write a critique of the each team member:

* Explain each team-member's assigned role and what they were generally tasked to accomplish
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
Demonstration of the Skeleton site with Login working | 3
Demonstration of all team-members running the local development version of the project | 3
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
  * If recorded, find a quiet place, focus on audio and or use head phones and make a quality recoding.

### What to Deliver to Canvas

Each person must deliver the URL to their Critique reports at the beginning of Sprint Presentation Day, Monday 10 AM. In your private GitHub repo under `itmt-430` > `sprint-02` > `Readme.md`.

The project manager in addition has to submit a document under the `sprint-02` folder named `report.md` that is a written report collecting all of the artifacts presented in a single cohesive status report. This will count for 10 points of the PMs grade and is presented in markdown.

Feedback will be given on each submission.
