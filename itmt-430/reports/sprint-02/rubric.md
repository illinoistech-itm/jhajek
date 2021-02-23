# Sprint-02 Grading Rubric

## Grading Style

The second sprint report will be defined by your own group.  The goals per person will be laid out based on your User Story and you will break the work into parts and based on your goals, you will essentially grade yourself.

## Points

The assignment will be 10 points cumulative.

- 2 points for the UI/UX portion
- 2 points for the Security Assumptions
- 2 points for IT and Infrastructure Report
- 2 points for Developer and Coding assumptions
- 1 points for the cumulative report
- 1 points for the Presentation style
  
  - The grading for the presentation will be a standard presentation
  - Was there a clear opening?
  - Was there a clear explanation of the entire report content (not read of the page)?
  - Was there a clear conclusion?

Each section will be graded on a Likert Scale:

- Meets expectations
- Somewhat meets expectations
- Somewhat meets expectations, with a few missing items
- Doesn't meet expectations
- Non-effort
- 2, 1.6, 1.5, 1.2, and .5 points respectively
- 1, .8, .7, .6, and .5 points respectively

## Content

The deliverable will be a single file named **sprint-02.md** located in a folder named **sprint-02** under the **reports** folder in your team GitHub repo. This sprints' minimum goal is to deploy a monolithic skeleton application that has functioning login and a main page.

### Operating Systems and IT Infrastructure

- Using Packer and Vagrant you will build a single Linux Virtual Machine as a monolithic application (Sprint 3 we will change our application into a three tier app).  You can use your choice of CentOS or Ubuntu Linux.  Store your scripts in a **code** folder on your repo, with Readme.md as with instructions.  This will include automated provisioning of all assumptions and secrets defined in the first sprint (firewall rules, admin accounts, user accounts, secrets/passwords, etc, etc.).  This will also require automated deployment of the ERD you created for your database and installation of the database product you chose.  All of these steps will be automated.

### Developer

Create the skeleton pages for all of your site based on your user story.  You need to have the authentication programmatically working so you can show the difference between admin and user stories.  

### Junior Developer and Security

For security you must create a non-root/admin user for the database activities following the concept of least privileges, that you define and explain.  You need to automate the creation of firewall rules using either (UFW or firewalld) on Ubuntu or Firewalld on CentOS and properly enable any services to start on boot--without manual intervention.

### UI/UX

Your job becomes a user tester upon each code deploy and release you need to build the system and test all of the features designed.  For instance if your team creates an authentication system, you need to user test this as well as confirm that all designed code conforms to the user/admin stories.  Responsible for updating any user interface diagrams

### Project Management

You will be responsible for allocating resources and guiding your team to accomplish the goals in the short time you set out. Must make note in the written report of all finished or done Trello tasks and show any artifacts that match those tasks.

## Individual Deliverables

This story will weave together the contributions of each team member into a single narrative.

## Deliverable

The Project Manager will submit the URL to the sprint-02.md on GitHub and a link to the recorded video presentation, it will be a group submission so only one is needed.  Don't forget!
