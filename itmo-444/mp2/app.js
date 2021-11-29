// Install these packages via npm: npm install express aws-sdk multer multer-s3

var express = require('express'),
    aws = require('aws-sdk'),
    bodyParser = require('body-parser'),
    multer = require('multer'),
    multerS3 = require('multer-s3');


// needed to include to generate UUIDs
// https://www.npmjs.com/package/uuid
const { v4: uuidv4 } = require('uuid');

aws.config.update({
    region: 'us-east-2'
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
        bucket: 'fall2021-jrh',
        key: function (req, file, cb) {
            cb(null, file.originalname);
            }
    })
});


// NodeJS needed to render the index file

app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

// Code Needed to post the form when the Submit button is hit
app.post('/upload', upload.array('uploadFile',1), function (req, res, next) {

// https://www.npmjs.com/package/multer
// This retrieves the name of the uploaded file
var fname = req.files[0].originalname;

// Now we can construct the S3 URL since we already know the structure of S3 URLS and our bucket
// For this sample I hardcoded my bucket, you can do this or retrieve it dynamically
var s3url = "https://fall2021-jrh.s3.amazonaws.com/" + fname;

// Use this code to retrieve the value entered in the username field in the index.html
var username = req.body['name'];

// Use this code to retrieve the value entered in the email field in the index.html
var email = req.body['email'];

// Use this code to retrieve the value entered in the phone field in the index.html
var phone = req.body['phone'];
// generate a UUID for this action

var id = uuidv4();

// Code for SQS Message sending goes here
// https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/SQS.html#sendMessage-property

// Write output to the screen
        res.write(s3url + "\n");
        res.write(username + "\n")
        res.write(fname + "\n");
        res.write("File uploaded successfully to Amazon S3 Server!" + "\n");
      
        res.end();
});

app.listen(3300, function () {
    console.log('Amazon s3 file upload app listening on port 3300');
});