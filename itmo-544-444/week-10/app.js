// Install these packages via npm: npm install express aws-sdk multer multer-s3

var express = require('express'),
    aws = require('aws-sdk'),
    bodyParser = require('body-parser'),
    multer = require('multer'),
    multerS3 = require('multer-s3');
      
const mysql = require('mysql2');

// needed to include to generate UUIDs
// https://www.npmjs.com/package/uuid
const { v4: uuidv4 } = require('uuid');

aws.config.update({
    region: 'us-east-1'
});

// initialize an s3 connection object
var app = express(),
    s3 = new aws.S3();

// configure S3 parameters to send to the connection object
app.use(bodyParser.json());

// I hardcoded my S3 bucket name, this you need to determine dynamically
var upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: 'fall2020-jrh',
        key: function (req, file, cb) {
            cb(null, file.originalname);
            }
    })
});

// initialize an RDS connection object
var rds = new aws.RDS();

// connect to RDS to retrieve RDS database instance endpoint
var dbhost = '';
// configure RDS parameters to send to the connection object
var params = {
    DBInstanceIdentifier: 'jrh-db-identifier',
};

rds.describeDBInstances(params, function(err, data) {
          if (err) console.log(err, err.stack); // an error occurred
          else     {
                   dbhost=data.DBInstances[0].Endpoint.Address;
                   console.log(data.DBInstances[0].Endpoint.Address);           // successful response
                   console.log(dbhost);
          }
});

app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

app.post('/upload', upload.array('uploadFile',1), function (req, res, next) {

// https://www.npmjs.com/package/multer
// This retrieves the name of the uploaded file
var fname = req.files[0].originalname;
// Now we can construct the S3 URL since we already know the structure of S3 URLS and our bucket
// For this sample I hardcoded my bucket, you can do this or retrieve it dynamically
var s3url = "https://fall2020-jrh.s3.amazonaws.com/" + fname;
// Use this code to retrieve the value entered in the username field in the index.html
var username = req.body['name'];
// Use this code to retrieve the value entered in the email field in the index.html
var email = req.body['email'];
// Use this code to retrieve the value entered in the phone field in the index.html
var phone = req.body['phone'];
// generate a UUID for this action
var id = uuidv4();

// create the connection to database
const connection = mysql.createConnection({
    host: dbhost,
    user: 'admin',
    password: 'ilovebunnies',
    database: 'company'
 });
 
// simple query to test making a query from the database, not needed for this application
connection.query(
    'SELECT * FROM `jobs`', 
    function(err, results) {
      console.log(results); // results contains rows returned by server
     }
  ); 

// hardcoded values for testing
//var recorddata = {RecordNumber: 45,CustomerName: 'jeremy',Email: 'hajek@iit.edu',Phone: '630-469-6411', Stat: 0, S3URL: "https"};
var recorddata = {RecordNumber: id,CustomerName: username,Email: email,Phone: phone, Stat: 0, S3URL: s3url};

 // https://github.com/mysqljs/mysql#escaping-query-values
 // SQL INSERT STATEMENT to insert the values from the POST
 var query = connection.query('INSERT INTO jobs SET ?', recorddata,
    function(err, results) {
        console.log(query.sql);
        console.log(err);
        console.log(results); // results contains rows returned by server
     }
  ); 

// Code for SQS Message sending goes here
// https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/SQS.html#sendMessage-property

// Write output to the screen
        res.write(s3url + "\n");
        res.write(username + "\n")
        res.write(fname + "\n");
        res.write(dbhost + "\n");
        res.write("File uploaded successfully to Amazon S3 Server!" + "\n");
      

        res.end();
});

app.listen(3300, function () {
    console.log('Amazon s3 file upload app listening on port 3300');
});