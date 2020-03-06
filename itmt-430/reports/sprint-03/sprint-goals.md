# Sprint Goals

These are a list of goals, in the listed 5 goals per job role, chose one listed here

## Coding and Programming

- Application Database Reads and Writes should go to different databases (see the replication section in IT Operations)
  - Or other approved framework
- A memory caching layer, such as [Redis](https://redis.io/ "Redis caching page") or [Memcached](https://www.memcached.org/ "Memcached main website")
- Database needs to have 15 users with actual data contained at deploy time
  - Needs to have Master Slave replication and or 3 nodes for replication

## Infrastructure and IT

- Operating System Platform of Choice (ITM 301, ITMO 356)
- Use of Data Store (ITMD 321, ITMD 411, ITMO 356)
  - Database or similar storage technology
- Datastore makes use of master/slave replication (ITMD 321, ITMD 411)
  - Master for database writes
  - Slave for database reads
- Creation of Data Schema
- Creation of infrastructure diagram tool and work flow (Visio or comparable) (ITM 301, ITMO 356)
- Team must generate at least 15 real “test” users and proper data to test functionality of a system
  - No system is ever used “blank” always fill it up with real data.

## Security

- Data encrypted at rest (ITMS 448)
- Use of https (ITMS 448, ITMO 356)
  - Self-signed certs
- Login authentication mechanism. Google authentication for login, such as:
  - [SQRL](https://www.grc.com/sqrl/sqrl.htm "SQRL introduction page")
  - [Google OAuth2](https://developers.google.com/identity/protocols/OAuth2 "Google OAuth2 authentication")

## UI/UX

- Use of Responsive Design (where applicable) (ITMD 361, ITMD 362)
- Use of user authentication (ITMD 411)
  - Must use HTTP Session
  - Different UI for Unauthenticated users
  - Have read/only features for unauthenticated users
  - Different UI for Authenticated users
  - Have a user account management page (EDIT Page)
  - Different UI for Administrative users
  - Have features for Operations in application
    - database dump
    - database restore feature
    - turn any/an upload feature to read-only
  - UI is modified per authenticated user via CSS
- Layout design (ITMD 361, 362, ITMM 471)
  - Diagrams of site functionality using layout tool
  - Diagrams of colors, fonts, and other usability features

## IT Operations

- Application needs to include:
  - A load balancer
  - minimum of 2 front-ends
  - A memory caching layer, such as [Redis](https://redis.io/ "Redis caching page") or [Memcached](https://www.memcached.org/ "Memcached main website")
- Database needs to have 15 users with actual data contained at deploy time
  - Needs to have Master Slave replication and or 3 nodes for replication
- Creation of Dev Environment on local laptop (ITMO 356) (ITM 301)
  - Application must always be in a working state
  - Each team member must be able to deploy the entire environment via script on their own hardware
  - Environment must be configurable via a scriptable deploy (suggested to use Packer and Vagrant)
  - No manual editing or installing
    - Note - Test and Production environments will be built after sprint 03

## Project Manager Goals

- They are already defined in the Written Report Rubric
