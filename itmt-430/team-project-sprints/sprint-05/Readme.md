# Sprint 05 Requirements and Deliverables

This document contains the Sprint-05 requirements and deliverables

![*XKCD 1760*](./images/tv_problems_2x.png "image of xkcd 1760 TV trouble")

## Objectives

* Deploy and explain user application testing
* Deploy and explain uses of Bug tracking and creation of GitHub issues
* Deploy final CSS revisions - matching original site plan
* Explore your site vulnerabilities via a Pen Test
* Ask 10 classmates (not in the class) to sign up and use your site (Done by UI/UX)
* Deploy to Production Infrastructure

## Outcomes

At the conclusion of this sprint project and the class you will have built upon the work in Sprint-04 and have added an additional cloud-based production environment. Your team will have deployed a working prototype. You will be able to explain the evolution and the obstacles you overcame. Your team will be able to deploy a working project in an automated fashion for demonstration. Your goal is to show a working prototype of the project at the end of sprint-05.

### Requirements

The list of requirements will be determined by your team and as part of the project management process. There will be a few additional items I will require and are listed below.

### Team Roles

For this sprint, there will be 5 team roles. For the teams with 4 - you can combine UI/UX with Dev2 and for the team with 6 you will add a Dev3. While these roles call for each person to focus an area -- **these roles are not exclusive**. Anyone can submit code for instance anyone can file a bug. The roles must rotate per sprint. This is an artificial inefficiency that I am introducing to allow all members to participate and experience each role.

#### Project Manager

* In charge of making sure that tasks are assigned, artifacts are being delivered, and project boards are updated accordingly.
* Project manager must actively manage the project, you are not the passive receiver of information the night before
* Must clearly document the state of the project at the start of the sprint so all of the work can be contrasted at the end
* Project Manager must make close recordings of what has changed from sprint to sprint
* Project Manager must also describe the task estimation process and describe what was completed and/or not completed
* Must manage the team members and facilitate communication and individual progress outside of class times

#### Developers

* Programmers responsible for implementing code, coordinating with the UI/UX developers and IT Operations to deploy code.
* Work with the developers to implement the designed UI/UX in code and CSS
* Implementation must match the design
* If your UI/UX design is incomplete need to complete it before any work can progress
* UI/UX design is a complete master blueprint of what your finished site will look like
* Help coordinate development into your team repo and using the provisioner scripts deploy your source code to your Proxmox Box environment
* Responsible for doing a site vulnerability analysis on **your** teams site/infrastructure

#### IT Orchestration and Security

* Responsible for designing and deploying all virtualized infrastructure templates (Proxmox and Packer)
* Responsible for working with Developers to configure login authentication
* Responsible for working with the team to coordinate the automated building of the entire application
* Responsible for creating any shell scripts required for automated deployment
* Responsible for training and teaching internal group members for deployment of infrastructure
* Responsible for noting and explaining all secrets management, firewall rules, and API security implemented
* Responsible for doing a site vulnerability analysis on **another** teams site/infrastructure

### Team Setup Items

In the team repo their will need to be a few additional folders added. Keep the team repo clean -- add your code and scripts into the proper folder -- do not place them at the root of the repo.

[*Git Seminar by Dr. Karl Stolley*](https://www.youtube.com/watch?v=ap7rqcD8uPs "Git Seminar by Dr. karl Stolley")

* A folder named: **code**
  * This will contain all application source code
* A folder named: **build**
  * This will contain all instructions on how to build and deploy your application
  * This will contain Packer build templates for building Proxmox virtual machine Templates
  * This will contain a `Readme.md` with detailed instruction on how to execute these scripts and a screenshot of what the finished artifact should look like - this is how you will know that you successfully deployed everything

### Project Management Tool and Task Difficulty Estimation

One of the first steps the team will undertake is to determine which atomic tasks it will undertake from your project management tool. Note that some additional tasks (such as deploying infrastructure will have to be added to the Atomic Task list). We will work this sprint using a points estimation process -- this process is commonly used in industry to give an evolving estimate of software readiness and complexity. Your team will use a scale of 1-5 points. 5 being a hard task and 1 being a simple task. These numbers are purely relative to your own team's estimation of your own abilities.  For Sprint 05 you will start with 25 total points of tasks to be assigned amongst the group members. If you finish them all, you can add increments of 15 points.  If you don't finish them, as long as you are progressing, your team will reevaluate their numerical rankings of tasks in the next sprint.

In the Project Management tool the 25 points worth of tasks need to have the point value assigned to that task and also have a name that is primary responsible and clearly marked.  This is how your Project Manager will report progress and how you will write your own and group critique at the end of the sprint. The professor will check in weekly during the beginning of the Lab days to check the current progress and help coordinate in anyway.  

**Note** -- this may require the group to *Swarm* on some initial items so that items that are blocking progress of the entire application don't hold up the entire team. Remember as a team-member it is your duty to swarm problems and solve them as a team (Third Way).

### Required Artifacts

The professor is prescribing a small number of **additional** required tasks to be selected amongst your 25 points

* Login
  * Use your @hawk accounts and Google OAuth for login authentication in your application code
* Infrastructure
  * Build each server needed in the 3-tier app as Virtual Machines using Proxmox via Packer and Terraform templates
  * Use Packer as the tool for automating the creation of the Proxmox Images/Templates
  * Deploy your code to a production cloud environment at the same time using Packer and [Terraform](https://www.terraform.io/ "Hashicorp Terraform webpage")
* 3 Tier Application
  * First tier is a Load Balancer
  * Second tier is 3 webservers
  * Third tier is a single datastore
* Deployment
  * You will have to build often, perhaps daily/nightly
* Usage of site
  * Pre-seed your site with 50 additional "real test users" and have them "ask" 10 questions and answer 1 other persons question (adjust the terms as appropriate to your site)
    * This is to show the search functionality and ability to store a complex discussion
  * Each member of your team needs to use the site and engage in making an account and at least 5 interaction
  * Posts must be real -- not "test test"


### 10 User Site Review

You will need to find 10 classmates (not on your team) and ask them to sit down and "use" your site.  This will include you having a short explanation of the site and then explaining what the task might be (each groups site functionality will differ). Your specific tasks might include: signup for the service, purchase an item, make a post, or search for an item. This is to be designed and accomplished by the UI/UX person. You as the interviewer need to watch and take notes on how they accomplish the task. Your system needs to be stable so that the artifacts of these experiments remain resident for the sprint presentation.

Record their information:

* Name of student
* Major
* Include a description of the tasks you gave them
  * Include your experience of how they did
* Write your conclusions


## Deliverables

* **All sections** critiques due on Monday April ~~22nd~~ 28th 10:00am.

### Individual Deliverables

The teamwork is cumulative but the grading is individual. Each team member will write a markdown based critique of their own work for the sprint and of their teammates' work. This will be anonymous and the purpose is to highlight good work and where improvement can be had, not to be punitive.

In the private repo provided to you (with your hawk ID), under the itmt-430 folder, create another folder that will be named for this sprint, **sprint-05**.  In this directory place a markdown based document named: **Report.md**

In the document **Report.md** include an H1 header called **Sprint-05** and then an H2 header: **Self-Critique** and detailing:

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

The report will be worth 15 points and will be graded on a scale listed below. And will be done live in class Monday April 24th. In addition to the critique, the Project Manager must deliver the presentation and will be graded on a 15 point scale for items delivered and 5 points (2.5 points each for the self and group critique).

Topic | Points Range |
----------|------
Introduction of your teammates | 1
Clear introduction and small summary of what will be presented with a clear transition | 1
Demonstration of project management tool and explanation of the 25 build point items -- tell us what initially was assigned and what was accomplished (show GitHub commit charts and Kanban Board) | 3
Demonstrate deployment of full working application on the provided cloud environment with explanation of each component | 3
Demonstrate login of user, posting of a question, and answering of a question | 3
Report of your and other teams Pen test results | 1
Summary of User Testing report | 2
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
  * There are OTS recording studios in the basement of Stuart Building and I have recording equipment available in the Smart Lab as well.

### What to Deliver to Blackboard

Each person must deliver the URL to their Critique reports at the beginning of the assigned Lab Time Sprint Presentation Day 04/28 10:00 AM. Feedback will be given on each submission.
