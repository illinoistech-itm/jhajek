// Initialize and AWS JavaScript SDK S3 Client connection
// https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/client/s3/command/ListBucketsCommand/
const { S3Client,ListBucketsCommand } = require('@aws-sdk/client-s3');
const express = require('express');
var multer = require('multer');
var multerS3 = require('multer-s3');
// Variable to store the S3 raw_bucket_name
var bucket_name = "";
// Initialize the express server -- the name app must match the .js file we are using
// hence app.js
const app = express();

// code to list S3 buckets and retrieve name of the Raw Bucket

(async () => {
  const client = new S3Client({ region: "us-east-2", signatureVersion: 'v4'  });
  const command = new ListBucketsCommand({});
  try {
    const response = await client.send(command);
     for ( element of response.Buckets ) {
             if ( element.Name.includes("raw") ) {
                     console.log(element.Name)
                     bucket_name = element.Name
             } } // end of forloop

  } catch (err) {
    console.error(err);
  }
})();
/*
// async function to query DynamoDB Tables
  const { DynamoDBClient, ListTablesCommand } = require( "@aws-sdk/client-dynamodb");
(async function() {
  const dbClient = new DynamoDBClient({ region: 'us-east-2' });
  const command = new ListTablesCommand({});

  try {
    const results = await dbClient.send(command);
    console.log(results.TableNames.join('\n'));
  } catch (err) {
    console.error(err);
  }
})();
*/

// Code from Multer-S3 sample page to help take the Image we are POSTing and push it to S3
//https://www.npmjs.com/package/multer-s3
 // instantiate an s3 connection object
//const { S3Client } = require('@aws-sdk/client-s3')

const s3 = new S3Client({  region: "us-east-2"});
const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: 'raw-bucket-jrh',
    metadata: function (req, file, cb) {
      cb(null, {fieldName: file.fieldname});
    },
    key: function (req, file, cb) {
      // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/now
      cb(null, Date.now().toString())
    }
  })
})

// Request to index.html or / express will match this route and render this page
app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

// Instantiate a route /upload
app.post('/upload', upload.array('uploadFile',1), function(req, res, next) {
  res.send('Successfully uploaded ' + req.files.length + ' files!')
})

// Instantiate the Express Server and have it listen on port 80
app.listen(3000, function () {
console.log('Amazon s3 file upload app listening on port 3000');
});