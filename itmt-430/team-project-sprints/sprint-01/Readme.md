# Sprint 01 Requirements and Deliverables

This document contains the Sprint-01 requirements and deliverables

## Objectives

* Explore Collaboration and Design principles with a team of your peers
* Develop and Design the outlines of a complex 3-tier web application
* Integrate version control and Kanban based project tooling
* Determine and assign design tasks to team members
* Explore the facets of team based design

## Outcomes

At the conclusion of this sprint project you will have engaged in designing and collaborating with your team members to begin the first step to create your three-tier web-app project.  This design phase will integrate version control and Kanban based project tooling and allow you to explore the facets of team based design as you would face in the real world.

### Requirements

There are a long list of requirements that are unique to this Sprint that won't be repeated in the subsequent sprints but are vitally important to your success as a team and as an individual. You could describe this as a meta-phase without any explicit code deliverables.

### Project Manager and Team Roles

For the first sprints there are many jobs that need to be accomplished and the role other than the Project Manager will be loosely defined.  Other than the Project Manager, roles do not need to be directly defined, but the Project Manager is the leader of the team for the duration of the Sprint.  

### Team Items to Setup

Make sure each person has signed up to be on a team by Monday 01/23/22 -- See CONTENT section in BlackBoard for Signup Link

While there are many solutions to the tools required I have provided a small set of sample and free tools that work together well.  Alternatives are welcome as long as they meet the specific requirements listed.

* The team needs to create a Project Management Kanban based tool
  * This needs to be a hosted web solution of your choice
    * Recommendations: [Trello.com](https://trello.com/ "Trello web site") or [Basecamp](https://basecamp.com/ "Basecamp website")
  * Need to invite all team members to it
  * Need to invite the instructor to the project - **hajek@hawk.iit.edu**
  * Must be used during the entire project to reflect work-in-progress and work completed
  * Project Management tool needs to have Chat based notification integration
  * Google Docs is not a valid choice for a Project Management Tool as it does not meet the fist requirements

* The team will use Trunk-based Git development
  * This is a bit different than branched based development - but is widely used in industry, but requires some coordination
  * Professor will invite each team-member to a team repo which you will have Admin access to (will be done 01/23/22)
  * This is to help the team focus on collaborating and understanding how code is developed and deployed
  * All design docs, instructions, code, diagrams, and tests will be updated and kept in the team repo
  * Google Docs is not an adequate solution for team based Trunk Development

* Signup for Team Chat Tool
  * This will enable synchronous and asynchronous out of band communication between members and the professor if questions arise
    * Invite: **hajek@hawk.iit.edu**
    * Recommendations: [Slack](https://slack.com "Slack website")
    * Recommendations: [Discord](https://discord.com "Discord website") -- need to have integrations with Chat and Project Management tools
  * Must have the ability to add notifications for Project Management boards and Git commits to the Chat tool
  * This will allow for a central pooling of resources and knowledge
  * Facebook Messenger and SMS are not adequate solutions

### Team Charter

This is important as this is the document that your team will write up in markdown, place in the root of your team repo, and will be the rules of work engagement for your team.  Like the [Mayflower Compact](https://en.wikipedia.org/wiki/Mayflower_Compact "Wiki Article for Mayflower Compact"), this document will determine how work will flow, communication rules and method, consequences, and restoration methods.

This document is important as it protects your team members and gives you recourse if for some reason members are not participating or delivering their requirements.  This also lays ground work for conflict resolution as well as in a last case scenario--separation from the team. In more modern terms you may see the phrase, **code-of-conduct** used as well.  The purpose of a document like this is never to be punitive but to establish boundaries on what is acceptable behavior for a community or team.

Place a markdown document named: **Compact.md** in the root of your team directory.  In the document address these areas:

* How work will flow
* Communication rules and methods
* Consequences
* Restoration methods

The document doesn't need to be extensive, but all parties need sign (place name and email below) and be in agreement.  If you need some help or advise I have some material that can help you or reference material from your Project Management class, ITMM 471.

### Team Readme.md

In the root of the team repository provided in the Readme.md add a section noting which lab section and who are the members of the team.

### Project About.md

You will need to provide a markdown document named: **About.md** in the root of the team repository.  This document will describe the general scope and outline of the project.

In the **About.md** add a paragraph or two describing the general function of your proposed project. The default template will be a 3-tier, multi-user Q&A website -- similar to [StackOverflow](https://stackoverflow.com "Stackoverflow website"). Other ideas and proposals are welcome -- just run them by the instructor to make sure they are robust enough for the scope of the class.

No programming or code design is required at this time.

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
*.iso
variables.pkr.hcl
*.priv
.DS_Store
id_rsa
id_rsa*
id_rsa.pub
.Vagrantfile*
```

### UI/UX Design

In a folder in the team repository placed in the root the repo named **design**, place all the needed design documents.  These might be images or could be skeleton HTML.  The purpose of this directory is that the team needs to design the entire functionality on paper before coding anything.  This is commonly known as design document or requirements gathering.  Your team has to decide the use of colors, buttons, function of each page, and the data collection points (forms and textboxes). This document will be used in the future sprints to help the Project Managers to assign tasks and check that committed code matches the design documents.  Having this document is critical to success, otherwise all progress is an illusion if you don't know what you should be working towards.

### Entity Relationship Diagram

Based on completing the UI/UX design you will be able to create an entire Entity Relationship diagram.  This will show the structure or schema of the database you end up working on. The ERD can be draw using a diagram tool and stored in the **design** folder for reference.  In addition, from the ERD you can generate SQL CREATE statements to generate this schema.  This will be used in t 2 but is required by the end of Sprint 01.

### Creation and Listing of Application Tasks

Based on the creation of the UI/UX design, this will give your team a list of atomic tasks to accomplish.  These are things such as the login mechanism -- this is a good atomic task to start with.  *"Get the website working"* is not a very good atomic task -- when is it finished? The team will break all the tasks for the entire site down and then assign each task a card or a task.  This phase will just require the listing of all the atomic tasks to finish the project, no need to assign tasks yet, that will happen in Sprint 02.  This is a team task as the project is everyone's responsibility.

This will be accomplished on the teams Project Management tool, and notification will show in the Chat Channel

## Deliverables

Upon the following Lab time, Jan 31st and February 2nd your teams project manager will give an approximate 20 minute presentation of the results of your teams first sprint.

### Individual Deliverables

The teamwork is cumulative but the grading is individual. Each team member will write a markdown based critique of their own work for the sprint and of their teammates' work.  This will be anonymous and the purpose is to highlight good work and where improvement can be had, not to be punitive.

In the private repo provided to you (with your hawk ID), under the itmt-430 folder, create another folder that will be named for this sprint, **sprint-01**.  In this directory place a markdown based document named: **Report.md**

In the document **Report.md** include an H1 header called **Sprint-01** and then an H2 header: **Self-Critique** and detailing:

* Any roles or jobs you had for the sprint
* Detail the work you accomplished and delivered
* Self-Critique what you did and what could have gone better

In the second part of the document, include and H2 header: **Group-Critique** and write a critique of the each team member's role, the contributions that made for the sprint, and any notes or improvements that could be done.  Make use of GitHub commits, Project Management board or the Chat Channel to find artifacts

#### Points for Self-Critique

The points for the critique items will break down as follows:

Topic | Points Range |
----------|------
Clear Explanation of your own role | 3
Did your listed accomplished work match what was describe? | 3
Did your self-critique cover or mention any proposed deficiencies? | 3
Was your markdown proper and well formed HTML when rendered? | 1

#### Points for Group Critique

The points for the critique items will break down as follows:

Topic | Points Range |
----------|------
Did you cover each team members contributions? | 3
Did you add constructive and or productive critical feedback? | 3
Did you make note of the artifacts each team member contributed? | 3
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
Clear introduction and small summary of presentation | 1
Clear conclusion and small summary of presentation | 1
Introduction of your teammates | 1
Demonstration your team Compact | 3
Demonstration of project tooling | 3
Demonstration of project overview from the About.md | 3
Walk-through of your site | 3

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

Demonstrate the implementations of the above requirements

* Introduce your teammates
* Demonstrate your team Compact
* Show Project Management Tool, GitHub, and Chat tool integration and that each member is participating
* Demonstrate your project overview form the About.md
* Present a walk-through of your site's design documents, explaining its functionality

### What to Deliver to Blackboard

Each person must deliver the URL to their Critique reports at the beginning of the assigned Lab Time Sprint Presentation Day.  Feedback will be given on each submission.
