# Project-Code

This directory contains the sample NodeJS "hello world" application code, as well as the Nginx configuration file to create a proxy for the NodeJS application.  

By default Nginx will listen on port 80, the NodeJS app will listen on port 3000, but there is a route in the Nginx config that allows you to access the NodeJS "hello world" via the URL `/app`
