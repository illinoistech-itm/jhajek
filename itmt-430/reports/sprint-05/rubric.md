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
  - Create a virtual machine based Load-Balancer to route between two copies of the front end virtual machines (For example: Nginx)
  - Include a script that will build each of these discrete systems as virtual machines automatically, include instructions how to do this in the ```install.md``` located in the root of the GitHub repo
    - At a minimum of 4 systems: Load Balancer, Frontend 1, Frontend 2, Backend-datastore
  - Include in the *Diagrams* folder a diagram of all of the discrete servers and their IP addresses in your application (All systems need to be on a discrete server)
  - Include a list of external packages per system being installed for this application via package manager that were added or removed since sprint-04
- Developer
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Show in the scripts required to build the Infrastructure, how you added the ability to clone application source code from your private repo to your local application
  - Show the creation of a non-root Database user and a brief explanation the reason for the permissions granted
  - Show that database encryption at rest is enabled from the code
- Junior Developer
  - List all tasks that you have completed along with the artifacts proving they are complete (GitHub commit URL and Project Management artifact screenshot)
  - Create a feature and functionality on the Admin portal of your site that allows an admin to export (or dump) the entire database to a local file
  - For the 15 "test" user accounts, create 2 actions per user upon automated deploy of the system
    - For instance, have each user *buy* two things, or make two posts, or two uploaded photos, or flip two buttons
  - Show from the code the firewall ports opened on each discrete vm
- Project Manager
  - List any detailed assumptions your team made explaining deliverable context as needed
  - Instructor will execute instructions in your `install.md` file and recreate your live demonstration, so test, test, test.

### Presentation Rubric

Presentation is worth 20 points and will be submitted by video recording to Blackboard. **Each team member** needs to record the following steps with your camera in the upper right corner and annotating the steps mentioned below.  There are some compromises we will have to make. For instance, the build time of each system might be long, we don't need to capture the entire build, just the beginning phases -- if you opt to build in parallel then showing the parallel build starting satisfies this requirement.

- We need to see you demonstrate, from the commandline, the automated build of each infrastructure component for the application
  - Capture just enough to see the building of the virtual machine begin (say 45 seconds worth)
  - **Note:** Using OBS or other software, you can pause the recording and restart it.  Resume the recording when the next component starts building and verbally annotate this.  
- Upon successful building and automated deployment of the infrastructure, begin recording again by opening a new browser tab, accessing your application and complete these steps:
  - Log in as an already created user and execute an action, then log out
  - Log in as another already created user and execute an action, then log out
  - Live demonstration of the creation of a new user account and log in as the user just created and execute one action, then log out
  - Log in as an admin and demonstrate the Database dump feature

## Presentation Deliverable

The due date for the video recording will be **11:59 PM Saturday May 2nd**.  The submission will be an **individual submission**.  I recommend using the [OBS Project](https://obsproject.com/ "OBS Project website") for screen and video capture, it is Opensource software and cross platform available - and records directly to MP4 files, but you are free to use other software.

Name the single video: ```lastname-firstname-teamXXd.mp4```. Where *XXd* equals team number plus day. Place the video on your school account Gmail drive.  Click the *Get Sharable Link*, submit this link to Blackboard on the individual deliverable.

### Written Report Deliverable

The deliverable will be a single file named **sprint-05.md** located in a folder named **sprint-05** under the **reports** folder in your team GitHub repo.  Submit the URL to Blackboard under the Sprint-05 Assignment deliverable by the Project Manager as the report is a **group submission**.  Due date for the report is **9:35 AM on Friday May 1st**.  Written report should follow the layout of document: ```written-report-submission-template.pdf```.
