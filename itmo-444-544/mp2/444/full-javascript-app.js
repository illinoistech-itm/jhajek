// Install these packages via npm: npm install express aws-sdk multer multer-s3
// Documentation for JavaScript AWS SDK v3
// https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/welcome.html

// https://docs.aws.amazon.com/sns/latest/dg/example_sns_Publish_section.html
// https://github.com/aws/aws-sdk-js-v3
// https://github.com/aws/aws-sdk-js-v3#getting-started
//const { SecretsManagerClient, ListSecretsCommand, GetSecretValueCommand } = require("@aws-sdk/client-secrets-manager"); // CommonJS import

const { SNSClient, ListTopicsCommand, GetTopicAttributesCommand, SubscribeCommand, PublishCommand } = require("@aws-sdk/client-sns");
const { S3Client, ListBucketsCommand, ListObjectsCommand, GetObjectCommand } = require('@aws-sdk/client-s3');

//const { RDSClient, DescribeDBInstancesCommand } = require("@aws-sdk/client-rds");

const express = require('express')
const app = express();
const multer = require('multer')
const multerS3 = require('multer-s3')
//const mysql = require('mysql2');
const mysql = require('mysql2/promise');
const REGION = "us-east-1"; //e.g. "us-east-1"
const s3 = new S3Client({ region: REGION });
///////////////////////////////////////////////////////////////////////////
// I hardcoded my S3 bucket name, this you need to determine dynamically
// Using the AWS JavaScript SDK
///////////////////////////////////////////////////////////////////////////

	var upload = multer({
        storage: multerS3({
        s3: s3,
        bucket: 'raw-jrh-itmo3',
        key: function (req, file, cb) {
            cb(null, file.originalname);
            }
    })
	});

//////////////////////////////////////////////////////
// Use this to get the Secret ARN
//

async function getSecretARN() {
  const client = new SecretsManagerClient({ region: "us-east-2" });
  const command = new ListSecretsCommand({});
  try {
   const results = await client.send(command);
    //console.log(results.SecretList[0].ARN);
   return results;

  } catch (err) {
    console.error(err);
  }
}

//////////////////////////////////
// Use the SecretARN to retrieve the secrets values
//

const getSecrets = async () => {
  
  let secretARN = await getSecretARN();
	//console.log("Secret ARN: ",secretARN.SecretList[0].ARN);
  const params = {
	  SecretId: secretARN.SecretList[0].ARN
  };
  const client = new SecretsManagerClient({ region: "us-east-2" });
  const command = new GetSecretValueCommand(params);
  try {
    const results = await client.send(command);
    //console.log(results);
    return results; 
  } catch (err) {
    console.error(err);
  }
};

/////////////////////////////////////////////////
// add list SNS topics here
//

const getListOfSnsTopics = async () => {
  const client = new SNSClient({ region: "us-east-2" });
  const command = new ListTopicsCommand({});  
    try {
    const results = await client.send(command);
    //console.log("Get SNS Topic Results: ", results);
    //console.log("ARN: ", results.Topics[0].TopicArn); 
    //return results.Topics[0]; 
    return results; 
  } catch (err) {
    console.error(err);
  }
};

///////////////////////////////////////////
// List of properties of Topic ARN
//
const getSnsTopicArn = async () => {
	
        let snsTopicArn = await getListOfSnsTopics();
//	console.log(snsTopicArn.Topics[0].TopicArn);
	const params = {
		TopicArn: snsTopicArn.Topics[0].TopicArn
	};
	const client = new SNSClient({region: "us-east-2" });
        const command = new GetTopicAttributesCommand(params);
	try {
		const results = await client.send(command);
		//console.log("Get SNS Topic Properties results: ",results);
		return results;
	} catch (err) {
		console.error(err);
	}
};

///////////////////////////////////////////////////
// Register email with Topic
//
const subscribeEmailToSNSTopic = async () => {

        let topicArn = await getListOfSnsTopics();

	const params = {

		Endpoint: "hajek@iit.edu",
		Protocol: 'email',
		TopicArn: topicArn.Attributes.TopicArn
	}

        const client = new SNSClient({region: "us-east-2" });
        const command = new SubscribeCommand( {params} );
        try {
                const results = await client.send(command);
                console.log("Subscribe Results: ", results);
	        return results; 	
	     
        } catch (err) {
                console.error(err);
        }
};

///////////////////////////////////////////////
// send message to topic and all subscribers
//
const sendMessageViaEmail = async () => {

	let publishMessage = await listObjects();
	let snsTopicArn = await getListOfSnsTopics();
	const params = {
		Subject: "Your imgage is ready!",
		Message: publishMessage,
		TopicArn: snsTopicArn.Topics[0].TopicArn
	};
	const client = new SNSClient({region: "us-east-2" });
	const command = new PublishCommand(params);
	try {
		const results = await client.send(command);
		//console.log("Send message results: ", results);
		return results;
	
} catch (err) {
	console.error(err);
}
};

//////////////////////////////////////////////////////////
// List and Cache Bucket code here
//
const listAndCacheBuckets = async () => {

	const client = new S3Client({region: "us-east-1" });
        const command = new ListBucketsCommand({});
	try {
		const results = await client.send(command);
		//console.log("List Buckets Results: ", results.Buckets[0].Name);
		const params = {
			Bucket: results.Buckets[0].Name
		}
		return params;
} catch (err) {
	console.error(err);
}
};
//////////////////////////////////////////////////////////
// Add S3 ListBucket code here
//
const listBuckets = async () => {

	const client = new S3Client({region: "us-east-1" });
        const command = new ListBucketsCommand({});
	try {
		const results = await client.send(command);
		//console.log("List Buckets Results: ", results.Buckets[0].Name);
		const params = {
			Bucket: results.Buckets[0].Name
		}
		return params;
	
} catch (err) {
	console.error(err);
}
};

///////////////////////////////////////
// ListObjects S3 
// https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-s3/interfaces/listobjectscommandoutput.html
// 
const listObjects = async () => {
	const client = new S3Client({region: "us-east-1" });
	const command = new ListObjectsCommand(await listBuckets());
	try {
		const results = await client.send(command);
		console.log("List Objects Results: ", results);
	        const url = "https://" + results.Name + ".s3.amazonaws.com/" + results.Contents[0].Key;	
		console.log("URL: " , url);
		return url;
	} catch (err) {
		console.error(err);
	}
};


///////////////////////////////////////////////
/// Get posted data as an async function
//
const getPostedData = async (req,res) => {
	try {
	let s3URL = await listObjects();
	res.write('Successfully uploaded ' + req.files.length + ' files!')

	// Use this code to retrieve the value entered in the username field in the index.html
	var username = req.body['name'];
	// Use this code to retrieve the value entered in the email field in the index.html
	var email = req.body['email'];
	// Use this code to retrieve the value entered in the phone field in the index.html
	var phone = req.body['phone'];
	// Write output to the screen
       // res.write(s3url + "\n");
        res.write(username + "\n");
	res.write(s3URL + "\n");
        res.write(email + "\n");
        res.write(phone + "\n");

        res.end();
	} catch (err) {
                console.error(err);
        }
}; 

////////////////////////////////////////////////
// Get images for Image Gallery
//
const getImagesFromS3Bucket = async (req,res) => {
	try {
		let imageURL = await listObjects();
	res.set('Content-Type', 'text/html');	
        res.write("Welcome to the gallery" + "\n");
        res.write('<img src="' + imageURL + '" />'); 
        res.end(); 
	} catch (err) {
                console.error(err);
        }
};

////////////////////////////////////////////////
// Lookup Database Identifier
//
const getDBIdentifier = async () => {

        const client = new RDSClient({region: "us-east-2" });
        const command = new DescribeDBInstancesCommand({});
        try {
                const results = await client.send(command);
                //console.log("List RDS results: ", results.DBInstances[0].DBInstanceIdentifier);
                //console.log("List RDS Endpoint results: ", results.DBInstances[0].Endpoint.Address);
                return results;
        } catch (err) {
                console.error(err);
        }

};

////////////////////////////////////////////////
// Select Record
//
const selectRecord = async () => {

        let dbIdentifier = await getDBIdentifier();
        let sec = await getSecrets();
        let obj = JSON.parse(sec.SecretString);
        try {


  const mysql = require('mysql2/promise');
        // create the connection to database
        const connection = await mysql.createConnection({
        host: dbIdentifier.DBInstances[0].Endpoint.Address,
        user: obj.username,
        password: obj.password,
        database: 'company'
        });

        // simple query
        const [rows,fields] = await connection.execute('SELECT * FROM `entries`');
		return rows;
        } catch (err) {
                console.error(err);
        }
};

////////////////////////////////////////////////
// Select and Print Record
//
const selectAndPrintRecord = async (req,res) => {

        let dbIdentifier = await getDBIdentifier();
        let sec = await getSecrets();
        let obj = JSON.parse(sec.SecretString);
        try {


        const mysql = require('mysql2/promise');
        // create the connection to database
        const connection = await mysql.createConnection({
        host: dbIdentifier.DBInstances[0].Endpoint.Address,
        user: obj.username,
        password: obj.password,
        database: 'company'
        });

        // simple query
        const [rows,fields] = await connection.execute('SELECT * FROM `entries`');
        res.set('Content-Type', 'text/html');
        res.write("Here are the records: " + "\n");
        res.write(JSON.stringify(rows));
        res.end();

		return rows;
        } catch (err) {
                console.error(err);
        }

};

////////////////////////////////////////////////
// Select and Print Record
//
const insertRecord = async (req,res) => {

        let dbIdentifier = await getDBIdentifier();
        let sec = await getSecrets();
        let obj = JSON.parse(sec.SecretString);
        try {


        const mysql = require('mysql2/promise');
        // create the connection to database
        const connection = await mysql.createConnection({
        host: dbIdentifier.DBInstances[0].Endpoint.Address,
        user: obj.username,
        password: obj.password,
        database: 'company'
        });

        // simple query
	let email = req.body['email'];
	let statement = 'INSERT INTO entries(RecordNumber,CustomerName,Email,Phone,Stat,RAWS3URL) VALUES("00000","NAME","' + email + '","000-000-0000",0,"http://");'
        const [rows,fields] = await connection.execute(statement);
       console.log(rows) 
		return rows;
        } catch (err) {
                console.error(err);
        }

};

////////////////////////////////////////////////////////////////////////////////
// Request to index.html or / express will match this route and render this page
//

app.get('/', function (req, res) {
    res.sendFile(__dirname + '/index.html');
});

//app.get('/gallery', function (req, res) {
//
//(async () => {await getImagesFromS3Bucket(req,res) } ) ();
//
//});

//app.get('/db', function (req,res) {
//(async () => { await getDBIdentifier() } ) ();
//(async () => { await selectAndPrintRecord(req,res) } ) ();
//});

app.post('/upload', upload.array('uploadFile',1), function (req, res, next) {

(async () => { await getPostedData(req,res) } ) (); 
(async () => { await getListOfSnsTopics(); })();
(async () => { await getSnsTopicArn() })();
(async () => { await subscribeEmailToSNSTopic() } ) ();
(async () => { await sendMessageViaEmail() } ) ();
//(async () => { await insertRecord(req,res) } ) ();
});

/////////////////////////////////////////////
// Call functions to retrieve values
/////////////////////////////////////////////

//(async () => { await getSecretARN() })();
//(async () => { await getSecrets() })();
//(async () => { await getListOfSnsTopics(); })();
//(async () => { await getSnsTopicArn() })();
//(async () => { await subscribeEmailToSNSTopic() } ) ();
//(async () => {await listBuckets() } ) ();
//(async () => { await listObjects() } ) ();
//(async () => { await sendMessageViaEmail() } ) ();


app.listen(80, function () {
    console.log('Amazon s3 file upload app listening on port 80');
   // (async () => console.log(await getSecretARN()))();
});

