const http = require('http');
const host = require('os');
const mysql = require('mysql2');
// get the client
const configReader = require('yml-config-reader')

const config = configReader.getByFiles('config.default.yml')
//console.log(config.db.userpass)

const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {
          res.statusCode = 200;
          res.setHeader('Content-Type', 'text/plain');
          res.end('Hello World' + host.hostname());
});

var query_results = "";

// create the connection to database
 const connection = mysql.createConnection({
   host: config.db.mmip,
     user: 'worker',
     password: config.db.userpass,
     database: 'posts'
     });

connection.connect((err) => {
   if(err){
      console.log('Error connecting to Db');
       return;
    }
  console.log('Connection established');
});


// simple query
 connection.query(
   'SELECT * FROM `comment`;',
     function(err, results, fields) {
         query_results = results;
         console.log(results); // results contains rows returned by server
        // console.log(fields); // fields contains extra meta data about results, if available
         console.log(err); // return the error
     }
            );


server.listen(port, hostname, () => {
          console.log(`Server running at http://${hostname}:${port}/`);
          console.log(query_results);
});