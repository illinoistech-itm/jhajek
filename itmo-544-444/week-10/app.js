// Install these packages via npm: npm install express aws-sdk multer multer-s3

var express = require('express'),
    aws = require('aws-sdk'),
    bodyParser = require('body-parser'),
    multer = require('multer'),
    multerS3 = require('multer-s3');
    
const mysql = require('mysql2');

aws.config.update({
    region: 'us-east-1'
});

var app = express(),
    s3 = new aws.S3();

app.use(bodyParser.json());

var upload = multer({
    storage: multerS3({
        s3: s3,
        bucket: 'fall2020-jrh',
        key: function (req, file, cb) {
            cb(null, file.originalname);
            }
    })
});

var paramss3 = {
    Bucket: 'fall2020-jrh', /* required */
   };

var rds = new aws.RDS();

var dbhost = '';

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
    var fname = req.files['uploadFile'][1];
// create the connection to database
const connection = mysql.createConnection({
    //host: 'jrh-db-identifier.cy1h2nhwscl7.us-east-1.rds.amazonaws.com',
    host: dbhost,
    user: 'admin',
    password: 'ilovebunnies',
    database: 'company'
 });
 

        res.write(fname);
        res.write(dbhost);
        res.write("<br />File uploaded successfully to Amazon S3 Server!<br />");

        res.end();
});

app.listen(3300, function () {
    console.log('Amazon s3 file upload app listening on port 3300');
});