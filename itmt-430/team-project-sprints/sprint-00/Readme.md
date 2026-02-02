# Sprint 00 Requirements and Deliverables

This document contains the Sprint-00 requirements and deliverables

## Objectives

* Explore Collaboration and Design principles with a team of your peers
* Develop and Design the outlines of a complex 3-tier web application
* Integrate version control and Kanban based project tooling
* Determine and assign design tasks to team members
* Explore the facets of team based design
* Explore and design a process for secret's management

## Outcomes

At the conclusion of this sprint project you will have engaged in designing and collaborating with your team members to begin the first step to create your three-tier web-app project. This design phase will integrate version control and Kanban based project tooling and allow you to explore the facets of team based design as you would face in the real world.

### Requirements

There are a long list of requirements that are unique to this Sprint that won't be repeated in the subsequent sprints but are vitally important to your success as a team and as an individual. You could describe this as a meta-phase without any explicit code deliverables.

### Project Manager and Team Roles

Each sprint will have 4-5 roles assigned that will be rotated each sprint (you only do one job once).  The roles are as follows:

* Project Manager - ITMM 471
  * Responsible for the accomplishment of work for the entire sprint. Active leader and assigner of tasks, directing flow.
* Developer 1 - ITM 311, 313, ITMD 411, ITMD 361, ITMO 340, ITMD 321
  * Both developers work together to deploy code that matches the tasks given to them by the team and through the project manager.
* Developer 2 - ITM 311, 313, ITMD 411, ITMD 361, ITMO 340, ITMD 321
* UI/UX and User Testing, ITMD 361, 362
  * Responsible for designing the UI/UX and working with the developers to implement the design in code, and then test that code to see it performs as designed.
* IT Operations and Security, ITM 301, ITMO 356, ITMS 448, ITMO 340, ITMD 321
  * Responsible for building, automating, securing, and deploying the team code to production infrastructure

### Team Items to Setup

While there are many solutions to the tooling required, I have provided a small set of sample and free tools that work well together. Alternatives are welcome as long as they meet the specific requirements listed.

* The team needs to create a Project Management Kanban based tool
  * This needs to be a hosted web solution of your choice
    * [Trello.com](https://trello.com/ "Trello web site")
    * [Basecamp](https://basecamp.com/ "Basecamp website")
    * [GitHub Projects](https://docs.github.com/issues/trying-out-the-new-projects-experience "website for GitHub projects")
  * Need to invite all team members to it
  * Need to invite the instructor to the project - **hajek@illinoistech.edu**
  * Must be used during the entire project to reflect work-in-progress and work completed
  * Project Management tool needs to have integration features for Discord, Git, and your PM tool
  * Google Docs is not a valid choice for a Project Management Tool as it does not meet the fist requirements

* The team will a use Git development workflow
  * Professor will invite each team-member to a team repo which you will have Admin access :white_check_mark:
  * This is to help the team focus on collaborating and understanding how code is developed and deployed
  * All design docs, instructions, code, diagrams, and tests will be updated and kept in the team repo
  * Will be making use of [Pull Requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request "webpage for creating pull requests")
  * Google Docs is not an adequate solution for team based Trunk Development - everything in the repository

* Sign up for Team Chat Tool
  * This will enable synchronous and asynchronous out of band communication between members and the professor if questions arise
    * Recommendations: [Discord](https://discord.com "Discord website") -- need to have integrations with Chat and Project Management tools
    * Drop the link in a DM in Discord
  * Must have the ability to add notifications from Project Management boards and Git commits to the Chat tool
  * This will allow for a central pooling of resources and knowledge
  * Facebook Messenger and SMS are not adequate solutions

### Team Charter

This is important as this is the document that your team will write up in markdown, place in the root of your team repo, and will be the rules of work engagement for your team.  Like the [Mayflower Compact](https://en.wikipedia.org/wiki/Mayflower_Compact "Wiki Article for Mayflower Compact"), this document will determine how work will flow, communication rules and method, consequences, and restoration methods.

This document is important as it protects your team members and gives you recourse if for some reason members are not participating or delivering their requirements. This also lays ground work for conflict resolution as well as in a last case scenario--separation from the team. The purpose of a document like this is never to be punitive but to establish boundaries on what is acceptable behavior for a community or team.

Place a markdown document named: **Compact.md** in the root of your team directory. In the document address these areas:

* How work will flow
* Communication rules and methods
* Consequences
* Restoration methods

The document doesn't need to be extensive, but all parties need sign (place name and email below) and be in agreement. If you need some help or advice I have some material that can help you or reference your material from your Project Management class, ITMM 471.

### Team Readme.md

In the root of the team repository provided in the Readme.md add a section noting which lab section you are and who are the members of the team.

### Project About.md

You will need to provide a markdown document named: **About.md** in the root of the team repository. This document will describe the general scope and outline of the project.

In the **About.md** add a paragraph or two describing the general function of your proposed project. No programming or code design is required at this time.

### Project .gitignore

Create a .gitignore file in the root of your team repository with the below content

```bash
# Files, Folders, security keys, and Binaries to ignore

*~
*.vdi
*.box
.vagrant/
*console.log
packer-cache/
packer_cache/
*.pem
*.ova
output*/
vagrant.d/
.vagrant.d/
*.iso
variables.pkr.hcl
*.priv
.DS_Store
id_rsa
id_rsa*
id_rsa.pub
id_ed25519*
.Vagrantfile*
```

## Decide on Team Project Idea

The project will you will have to plan, build, deploy, manage, and secure a 3-tier webapp. Your team will need to determine what the site will be and what it does. The team needs to keep in mind the site will be working by the end of sprint-02. Your team can choose a topic or subject for your site that you could use as a future resume piece. This will impact the rest of your sprint-01 deliverables.

The web application we are building will require state management, account management, and admin management workflows. All hardware and cloud platform access will be provided to you in Sprint-02, no need to secure outside hosting. We won't be using platforms like Firebase of Netlify, though those are good software, we want you to build the entire infrastructure.

### Additional Project Manager Task for Online section only

You will keep a log of who attended any team meetings and this will be published as part of your deliverables in an `attendance.md` file placed in `sprint-01` with the critique and report.

### Assign Team Roles

Sort your team members alphabetically - this will be the rotation for jobs each sprint

* Project Manager
* Developer 
* Junior Developer
* UI/UX and testing
* IT operations

### UI/UX Design

In a folder in the team repository placed in the root the repo named **design**, place all the needed design documents. These might be images or could be skeleton HTML. The purpose of this directory is that the team needs to design the entire functionality on paper before coding anything. This is commonly known as design document or requirements gathering. Your team has to decide the use of colors, buttons, function of each page, and the data collection points (forms and textboxes). This document will be used in the future sprints to help the Project Managers to assign tasks and check that committed code matches the design documents. Having this document is critical to success, otherwise all progress is an illusion if you don't know what you should be working towards.

### Entity Relationship Diagram

Based on completing the UI/UX design you will be able to create an entire Entity Relationship diagram. This will show the structure or schema of the database you end up working on. The ERD can be draw using a diagram tool and stored in the **design** folder for reference. In addition, from the ERD you can generate SQL CREATE statements to generate this schema. This will be used in sprint-01 but will naturally be available from the work of doing the system design.

### IT Operations

Determine the type of database/datastore you will use for your project, needs to be able to run on Linux, on a replicated cluster (At least two nodes) detail your choice, documentation for configuring a DB cluster, and which platform you have chosen.

### Developers

Will document and determine the development framework used for the project in agreement with the rest of the group.

### Team Deliverable

This sprint is unique as in most of the work is setup and configuration along with design. There will be one demonstration of all the required `.md` files listed in this document. 

The presentation in class during the scheduled lab time will be worth 10 points.

### What to Deliver to Canvas

Since it is a group deliverable (this one only) there will be a group submission of one person giving the URL to the private GitHub team repo.
