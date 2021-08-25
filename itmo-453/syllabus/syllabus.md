# ITMO 453 Opensource Server Administration

![](./syllabus/images/CoC_horiz_lockup_2019.jpg "COC Logo")

Semester: Fall 2021 Professor Jeremy Hajek

![*https://xkcd.com/350/*](./syllabus/images/network.png "XCKD 350 image URL")

---------------- --------------------------------------------------------
  **Professor**: Jeremy Hajek
        Address: Department of Information Technology & Management,
                 10 W. 33rd St., Chicago, IL 60616
      Telephone: 312.567.5937
          Email: hajek@iit.edu
         Office: Perlstein Hall Room 223A, 10 W. 33rd St.
   Office Hours: Mies Campus: Monday-Wed 11:30 -3:00, Thursday 2:00-3:00, Friday 12:00 to 2:00
         Online: book and appointment at:
                 [https://hajek.youcanbook.me](https://hajek.youcanbook.me "Booking APP URL")
---------------- --------------------------------------------------------

**Course Catalog Description:** Students learn the administration topics and concepts of IT orchestration, automation, monitoring, and metric collection. Topics include configuring industry standard automation tooling and using scripting to achieve immutable infrastructure. Students will learn how to monitor and collect and present metrics in regards to the infrastructure they deploy. [ITMO 453 Bulletin Description](http://bulletin.iit.edu/courses/itmo/ "ITMO 453 Bulletin Description")

**Prerequisites:** ITMP 340 and ITMO 356, Credit: Lab 3-0-3

**Lecture Day, Time & Place:** Monday and Wednesday 3:35 pm - 4:50 pm in [John T. Rettaliata Engineering Center](https://www.iit.edu/about/campus-information/mies-campus/mies-campus-map "IIT Campus Map URL"), room 032 on IIT’s Mies Campus in Chicago.

**Schedule of Topics/Readings:** All readings should be done prior to class. Do the readings!  

Session # | Date | Topic | Reading |
----------|------|:------|----------
1 | 08/24 | Introduction  | Practice of Cloud System Admin 1
2 | 08/26 | Tooling Lab 1  | Tooling Setup
3 | 08/31 | Chapter 1  | Practice of Cloud System Admin 2
4 | 09/02 | Lab 2  | Practice of Cloud System Admin 2
5 | 09/07 | Chapter 2  | Practice of Cloud System Admin 3
6 | 09/09 | Lab 3  | Practice of Cloud System Admin 3
7 | 09/14 | Chapter 3  | Practice of Cloud System Admin 4
8 | 09/16 | Lab 4  | Practice of Cloud System Admin 4
9 | 09/21 | Chapter 4  | Practice of Cloud System Admin 5
10| 09/23 | Lab 5 | Practice of Cloud System Admin 5
11| 09/28 | Chapter 5 | Practice of Cloud System Admin 6
12| 09/30 | Lab 6 | Practice of Cloud System Admin 6
13| 10/05 | Chapter 6 | NA
14| 10/07 | Lab 7 | NA
15| 10/12 | NA | No Class - Fall Break
16| 10/14 | NA | Midterm Exam
17| 10/19 | Mini Project 1 | MP1 Assigned
18| 10/21 | Mini Project 1 | -
19| 10/25 | Mini Project 1 | -
20| 10/28 | Mini Project 1 | MP1 Due
21| 11/02 | Mini Project 2 | MP2 Assigned
22| 11/04 | Mini Project 2 | -
23| 11/09 | Mini Project 2 | -
24| 11/11 | Mini Project 2 | -
25| 11/16 | Mini Project 2 | - Final Project Assigned
26| 11/18 | Mini Project 2 | MP 2 Due
27| 11/23 | Final Project | -
28| 11/25 | NA       | Thanksgiving Break - No Class
29| 11/30 | Final Project | -
30| 12/02 | Final Project | Final Project Due
31| 6-11  | Final Exam week

**Course Outcomes:**

This course will enable students to be ready to design, build, and implement logging and metrics in monitored applications. Implementing these foundations will allow any system administrator to integrate logging and metric collection to correlate with business objectives.

**Course Student Outcomes:** Students completing this course will be able to:

* Explain the difference between push and pull metrics
* Explain the difference between logging and metrics
* Describe event streams are and how they are used in monitoring and metric collection
* Explain the use of logging and metrics in  regards to Operating System containers
* Design, build, and implement logging and  metrics in monitored applications

**Topics to Be Covered**:

* a. Intro - Monitoring & Measurement Framework
* b. Managing events and Metrics & Graphing
* c. Event Routing and Collection
* d. Containers and Logs
* e. Building an app & Notifications
* f. Getting Started & Monitoring Nodes
* g. Service Discovery
* h. Alerting & Scaling and Reliability
* i. Instrumenting Applications & Logging
* j. Building Monitored Applications & Notification

**Required Textbook:**

The Practice of Cloud System Administration: Designing and Operating Large Distributed Systems, Volume 2, Thomas A. Limoncelli, Strata R. Chalup and Christina J. Hogan, 2014. ISBN: 978-0321943187

You will be using an existing or creating an account at [Amazon Web Services](https://aws.amazon.com/ "AWS Web services URL").  This will require a Credit Card for registration purposes -- but there won't be any extra cost.

**Readings:** Readings for the class will be assigned from the textbooks; there will be additional reading assigned in the form of online reading. All readings should be done before coming to class on the assigned date, and are mandatory and expected.  Generally if you do the readings you will excel in the course, as the lectures serve as a clarification and explanation of material you should al-ready be familiar with. Completion of reading may be verified by quizzes. Specific readings are assigned by topic above.

**Course Notes:**  It is recommended to take notes from the oral discussion portion of the class.

**Attendance:** Undergrad attendance is expected and will be counted as part of your grade.  

**Course Web Site:** [http://blackboard.iit.edu/](http://blackboard.iit.edu/ "Course Document Mangement Site URL")

**Blackboard:** The course will make intensive use of Blackboard [http://blackboard.iit.edu/](http://blackboard.iit.edu/ "Course Document Mangement Site URL") for communications, assignment submissions, group project coordination, providing online resources and administering examinations. All remote students will view the course lectures online via Blackboard, and online readings and other course material will be found on Blackboard.

**Assignments:**

Project/Examination: There will be 6 chapter review questions, 6 graded labs, 2 Mini Projects, 1 Final project, 1 Mid-term, 1 Final Exam

All Work will be submitted to GitHub to a private repository that you will be given access to

**Grading:** Grading criteria for (undergrad course number) students will be as follows:

Letter | Description | Percentage
-------|-------------|------------
A | Outstanding work reflecting substantial effort | 90-100%
B | Excellent work reflecting good effort | 80-89.99%
C | Satisfactory work meeting minimum expectations | 70-79.99%
D | Substandard work not meeting expectations | 60-69.99%
E | Unsatisfactory work |0-59.99%

The final grade for the class will be calculated as follows: (example)

   Name                  Grade    Total Points
----------------------- ------- ----------------
  Review Questions (6):   15%        120
               Lab (6):   15%        120
          Midterm Exam:   13%        100
            Final Exam:   13%        100
                   MP1:   13%        100
                   MP2:   13%        100
         Final Project:   13%        100
            Attendance:    5%         30
----------------------- ------- ----------------

**Late Submission:**  By default no late work will be accepted – barring situations beyond our control.

**Academic Honesty:**  All work you submit in this course must be your own.

**Plagiarism:** You must fully attribute all material directly quoted in papers and you must document all sources used in the preparation of the paper using complete, APA-style bibliographic entries. Including directly quoted material in an assignment without attribution or a bibliography entry for the source of the material is always plagiarism and will always be treated as such by me. No more than thirty-three percent of material included in any paper may be direct quotes. Students have submitted plagiarized material in seven of the last eight times I have taught this course and I will not tolerate it. If you submit plagiarized material you WILL receive a grade of ZERO for the assignment or exam question, an Academic Honesty Violation Report will be filed, and it may result in your expulsion from the course with a failing grade as per the IIT and ITM academic honesty policies. There is no excuse for not understanding this policy and if you do not understand it please let me know and I will be happy to discuss it with you until you do.

**Collaboration:** Students may only collaborate on assignments or projects that are explicitly designated as group assignments or projects. Students submitting work that is identical or in some cases even substantively the same will be asked to discuss the assignment with me. If one student admits to having copied the work, or if there is clear evidence who is guilty, the guilty student will be assigned a grade of zero. If no one admits to the offense or a reasonable determination of guilt cannot be made, each student involved will be assigned a grade of zero. In either case, an Academic Honesty Violation Report will be filed, and it may result in your expulsion from the course with a failing grade as per the IIT and ITM academic honesty policies.

**Our Contract:** This syllabus is my contract with you as to what I will deliver and what I expect from you. If I change the syllabus, I will issue a revised version of the syllabus; the latest version will always be available on Blackboard. Revisions to readings and assignments will be communicated via Blackboard.

**Disabilities:** Reasonable accommodations will be made for students with documented disabilities.  In order to receive accommodations, students must obtain a letter of accommodation from the Center for Disability Resources and make an appointment to speak with me as soon as possible.  My office hours are listed on the first page of the syllabus. The Center for Disability Resources (CDR) is located in 3424 S. State St., room 1C3-2 (on the first floor), telephone 312 567.5744 or disabilities@iit.edu.

**ARC Tutoring Center:** The university provides a free tutoring and study center called the [ARC](*https://www.iit.edu/arc "IIT Resource Center URL").  This is located newly in the basement of the Galvin Library and is open to all for walk in appointments as well as scheduled tutoring.
