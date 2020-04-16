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

- UI/UX
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Show (screenshot with highlights) all UI/UX components added since sprint-04 for the User Story and give a short explanation of their function
  - Show (screenshot with highlights) all UI/UX components added since sprint-04 for the Admin Story and/or Anonymous user and give a short explanation of their function
  - Add screenshot of a minimum of 5 additional GitHub issues/bugs reported, assigned, and resolved
- Infrastructure
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Create an Nginx based Load-Balancer to route between two copies of the front end virtual machine
  - Include a script that will build each of these discrete systems as virtual machines automatically, include instructions how to do this in the ```install.md``` located in the root of the GitHub repo
    - Now at a minimum of 4 systems: Load Balancer, Frontend 1, Frontend 2, Backend-datastore
  - Include in the *Diagrams* folder a diagram of all of the discrete servers and their IP addresses in your application (All systems need to be on a discrete server)
  - Include a list of external packages per system being installed for this application via package manager that were added or removed since sprint-04
- Developer
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Show in the scripts required to build the Infrastructure, how you added the ability to clone application source code from your private repo to your local application
  - Show the .sql schema file that creates your database.  If using MongoDB, show the JavaScript file.  Not a screen shot but put the code into the document
    - Just the schema: CREATE statements no need for any INSERT statements
  - Show the creation of a non-root Database user and a brief explanation the reason for the permissions granted
  - Show that https is enabled using local self-signed certs from the code
  - Show that database encryption at rest is enabled from the code
- Junior Developer
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Create a feature and functionality on the Admin portal of your site that allows an admin to export (or dump) the entire database to a local file
  - For the 15 "test" user accounts, create 3 actions per user upon automated deploy of the system
    - For instance, have each user *buy* three things, or make three posts, or three uploaded photos, or flip three buttons
  - Show from the code the firewall ports opened on each discrete vm
- Project Manager
  - Include a file  ```install.md``` in the root of the team GitHub Repo detailing all instructions to build and run your application
  - List any detailed assumptions your team made explaining deliverable context as needed

### Presentation Rubric

Presentation is worth 20 points and will be submitted by video recording. The due date for the video recording will be **11:59 PM Saturday May 2nd**.  The submission will be **individual submission**.  I recommend using the [OBS Project](https://obsproject.com/ "OBS Project website") for screen and video capture, it is Opensource software and cross platform available, but you are free to use other software.

Each person needs to record these following steps with your camera in the upper left corner and annotating the steps mentioned below.  There are some compromises we will have to make, for instance, the build time of each system might be long, we don't need to capture the entire build, just the beginning phases.

- From the commandline launch the script needed to build the infrastructure, as each virtual machines begins to build capture the beginning of this process annotating which system it is and then pause the recording during the build until the completion of the `packer build` and completion of the `vagrant up` process.  Resume the recording when the next component starts building and annotate this.  
  - Upon successful building of the infrastructure, begin recording by opening a new browser tab and complete these steps
- Log in as an already created user and execute an action your team has defined once, then log out
- Log in as an already created user and execute an action your team has defined once, then log out
- Live demonstration of the creation of a new user account and log in as the user just created and execute an action your team has defined once, then log out
- Log in as an admin and demonstrate the Database dump feature

## Presentation Deliverable

Name the single video: lastname-firstname-teamnumber.mp4.  Place the video on your school account Gmail drive.  Click the *Get Sharable Link*, submit this link to Blackboard on the individual deliverable.

### Written Report Deliverable

The deliverable will be a single file named **sprint-05.md** located in a folder named **sprint-05** under the **reports** folder in your team GitHub repo.  Submit the URL to Blackboard under the Sprint-05 Assignment deliverable by the Project Manager as the report is a **group submission**.  Due date for the report is **9:35 AM on Friday May 1st**.  Written report should follow the layout of document: ```written-report-submission-template.pdf```.
