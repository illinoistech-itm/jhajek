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
  const client = new S3Client({region: "us-east-2", signatureVersion: 'v4'  });
  const command = new ListBucketsCommand({});
  try {
    const response = await client.send(command);
       // console.log(); // print the JSON
     for ( element of response.Buckets ) {
             if ( element.Name.includes("raw") ) {
                     console.log(element.Name)
                     bucket_name = element.Name
             } } // end of forloop

  } catch (err) {
    console.error(err);
  }
})();