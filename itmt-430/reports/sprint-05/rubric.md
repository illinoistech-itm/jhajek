# Sprint-05 Grading Rubric

## Objectives

- Display understanding and demonstration of the each of the five technical roles by deploying a working prototype of your application and infrastructure

## Outcomes

- Your team will deliver a written report written in markdown and placed on your team's private GitHub repo.
  - In the location of: ```reports > sprint-05 > sprint-05.md```
- The Project Manager of your team will give a live demonstration of requested site features
  - Each team member will begin and demonstrate a clean build/deploy of the application

## Points

The assignment will be graded in two parts, 80 points for the report, 20 points for the presentation; 100 points cumulative.

### Written Report Rubric

16 points per item, 2 points off per item

- UI/UX & Testing portion
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Show (screenshot with highlights) all UI/UX components added since sprint-04 for the User Story and give a short explanation of their function
  - Show (screenshot with highlights) all UI/UX components added since sprint-04 for the Admin Story and/or Anonymous user and give a short explanation of their function
- Infrastructure
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Include in the *Diagrams* folder a diagram of all of the discrete servers and their IP addresses in your application (All systems need to be on a discrete server)
  - Include a script that will build each of these discrete systems as virtual machines automatically, include instructions how to do this in the ```install.md``` located in the root of the GitHub repo
  - Include a list of external packages being installed for this application via package manager
- Developer
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Show in the scripts required to build the Infrastructure, add the ability to clone application source code from your private repo to your local application
  - Show the .sql schema file that creates your database.  If using MongoDB, show the JavaScript file.  Not a screen shot but put the code into the document.
  - Show that https is enabled using local self-signed certs
- Junior Developer
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Add screenshot of a minimum of 5 additional GitHub issues/bugs reported and assigned
- Project Manager
  - Include a file  ```install.md``` in the root of the team GitHub Repo detailing all instructions to build and run your application
  - List any detailed assumptions your team made explaining deliverable context as needed

### Presentation Rubric

Presentation is worth 20 points and needs to **only** contain the following:

- Project Manager will demonstrate each "action" you have defined on your application
  - Log in as an already created user and execute all of the actions your team has defined once, then log out
  - Log in as an user and execute all of the actions your team has defined once, then log out
  - Live demonstration of the creation of a new user/new admin account
  - Live demonstration of one user action on your site -- such as creating a ticket, or making a purchase
  - Each team member (excluding Project Manager), once they arrive in the class on presentation day must begin a clean build of the system to be demonstrated at the end of the class on their own laptop and/or lab computer and demonstrate a user login and logout

### Written Report Deliverable

The deliverable will be a single file named **sprint-05.md** located in a folder named **sprint-05** under the **reports** folder in your team GitHub repo.  Submit the URL to Blackboard under the Sprint-03 Assignment deliverable by the Project Manager as the report is a group submission.  Due date for the report is **9:35 AM the the day of your class lab time**, April 29 & 30 & May 1.  Written report should follow the layout of document: ```written-report-submission-template.pdf```.

## Presentation Deliverable

There is no deliverable for the in-class presentation, that will be graded during the class based on the Presentation Rubric.
