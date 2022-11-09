// Install these packages via npm: npm install express aws-sdk multer multer-s3
// Documentation for JavaScript AWS SDK v3
// https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/welcome.html

const { S3Client } = require('@aws-sdk/client-s3');
var express = require('express'),

    bodyParser = require('body-parser'),
    multer = require('multer'),
    multerS3 = require('multer-s3');

// needed to include to generate UUIDs
// https://www.npmjs.com/package/uuid
const { v4: uuidv4 } = require('uuid');


// initialize an s3 connection object
var app = express();
    //s3 = new aws.S3();
    const REGION = "us-east-1"; //e.g. "us-east-1"
    // Create an Amazon S3 service client object.
    const s3 = new S3Client({ region: REGION });
app.use(bodyParser.json());

///////////////////////////////////////////////////////////////////////////
// I hardcoded my S3 bucket name, this you need to determine dynamically
// Using the AWS JavaScript SDK
///////////////////////////////////////////////////////////////////////////
var upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: 'jrh-itmo-raw',
        key: function (req, file, cb) {
            cb(null, file.originalname);
            }
    })
});

// Request to index.html or / express will match this route and render this page
app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

// when some one hits the post button this will happen
app.post('/upload', upload.array('uploadFile',1), function (req, res, next) {
    
res.send('Successfully uploaded ' + req.files.length + ' files!')
// https://www.npmjs.com/package/multer
// This retrieves the name of the uploaded file
//var fname = req.files[0].originalname;
// Now we can construct the S3 URL since we already know the structure of S3 URLS and our bucket
// For this sample I hardcoded my bucket, you can do this or retrieve it dynamically
var s3url = "https://jrh-itmo-raw.s3.amazonaws.com/" + fname;
// Use this code to retrieve the value entered in the username field in the index.html
var username = req.body['name'];
// Use this code to retrieve the value entered in the email field in the index.html
var email = req.body['email'];
// Use this code to retrieve the value entered in the phone field in the index.html
var phone = req.body['phone'];
// generate a UUID for this action
var id = uuidv4();

// Write output to the screen
        res.write(s3url + "\n");
     //   res.write(username + "\n")
     //   res.write(fname + "\n");
     //   res.write(email + "\n");
     //   res.write(phone + "\n");                
        res.write("File uploaded successfully to Amazon S3 Bucket!" + "\n");
      
        res.end();
});

app.listen(80, function () {
    console.log('Amazon s3 file upload app listening on port 80');
});