# Sprint-03 Grading Rubric

## Grading Style

~~The second sprint report will be defined by your own group.  The goals per person will be laid out based on your User Story and you will break the work into parts and based on your goals, you will essentially grade yourself.~~

## Points

The assignment will be 10 points cumulative

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

The deliverable will be a single file named **sprint-03.md** located in a folder named **reports** under the **sprint-03** folder in your team GitHub repo.

### Written Report Rubric

### Operating Systems and IT Infrastructure

- Using Packer and Vagrant you will begin to break your monolithic application up into at least 2 servers (frontend and backend)
  - Using the host only network declared via Vagrant
    - 192.168.33 for frontend
    - 192.168.33.34 for datastore/database
  - Store your scripts in a **code** folder on your repo
  - Update the `install.md` template file with build and install instructions  
    - This will include automated provisioning of all assumptions and secrets defined in the first sprint (firewall rules, admin accounts, user accounts, secrets/passwords, etc, etc
  - This will also require automated deployment of the ERD you created for your database and installation of the database product you chose.  All of these steps will be automated.

### Developer

With the Authentication proved working, now begin to complete the User Story by deploying:

- Working user registration page and process
- Working user login (at least 3 accounts demonstrated)
- Create and identify to us at least 3 additional pages/functionalities
  - For instance demonstrate the ability for a logged in user to add an item for sale

### Junior Developer and Security

For security you must create a non-root/admin user for the database activities following the concept of least privileges, that you define and explain.  You need to automate the creation of firewall rules using either (UFW or firewalld) on Ubuntu or Firewalld on CentOS and properly enable any services to start on boot--without manual intervention.

You will now enable and restrict the firewall rules so that only the front end IP address can connect to the backend database.  

- Create firewall rules
- Work with Operation to include the creation of at least 3 user accounts
  - Insert two items per test user (post an item, place a question, or answer a question)
  - Insert these to your database via provisioner script in Packer

### UI/UX

Demonstrate and explain how the created artifacts by the Developer match the User Story UI/UX artifacts in your `diagrams` folder.  If these items do not match explain why and how this will be remedied.

### Project Management

You will be responsible for allocating resources and guiding your team to accomplish the goals in the short time you set out. Must make note in the written report of all finished or done Trello tasks and show any artifacts that match those tasks.  

## Deliverable

The Project Manager will submit the URL to the sprint-03.md on GitHub and a link to the recorded video presentation, it will be a group submission so only one is needed.  Don't forget!

Video presentation should demonstrate the Developer requirements

- Create two user accounts
- Log into one of those accounts
- Take an action
- Log out
- Log into the other account
- Log out
