const http = require('http');
const host = require('os');
const mysql = require('mysql2');
const mongoose = require('mongoose');
// get the client
const configReader = require('yml-config-reader')

const config = configReader.getByFiles('config.default.yml')
//console.log(config.db.userpass)

const hostname = '0.0.0.0';
const port = 3000;

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

  const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.write('The SQL query results are: ' + JSON.stringify(query_results));
    res.write('Connection to Mongo status:' + conn_status)
    res.end('Hello World' + host.hostname());

  });

  // create variable to display connection string
  var conn_status="";
  // mongo connection string
const mongoose = require('mongoose');
mongoose.connect('mongodb://ms1/studentrecords', {useNewUrlParser: true, useUnifiedTopology: true});

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {
  conn_status="We are connected to MongoDB!";
});

server.listen(port, hostname, () => {
          console.log(`Server running at http://${hostname}:${port}/`);
});