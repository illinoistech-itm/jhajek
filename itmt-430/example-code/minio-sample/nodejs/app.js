// Install Minio and Multer-s3 packages via the package.json: npm install command
// Minio JavaScript SDK
// https://min.io/docs/minio/linux/developers/javascript/API.html
  
import express from 'express'
const app = express();
import multer from 'multer'
import multerS3  from 'multer-s3'
import mysql from 'mysql2/promise'
import 'dotenv/config'
//require('dotenv').config()
import * as Minio from 'minio'
//////////////////////////////////////////////////////////////////////////////
// Retrieve these values from Vault... I would read them from a .env file
// DotEnv is recommended as the easiest approach 
// https://www.npmjs.com/package/dotenv
// MINIOENDPOINT = "https://system54.rice.iit.edu"
// You should store the endPoint URL, accessKey and SecretKey values in Vault
// Retrieve them and populate your .env file
// These keys are separate from the Proxmox Keys... more secrets to manage 
//////////////////////////////////////////////////////////////////////////////
const minioClient = new Minio.Client({
    endPoint: process.env.MINIOENDPOINT,
    port: 443,
    useSSL: true,
    accessKey: process.env.MINIOACCESSKEY,
    secretKey: process.env.MINIOSECRETKEY,
  })
//////////////////////////////////////////////////////////////////////////////
//  bucketname is your hawkID - for now we will start with a single bucket per
//  team, but we can create more if needed
var bucketName = "rahmed16";
//////////////////////////////////////////////////////////////////////////////
// https://www.npmjs.com/package/multer-s3
var upload = multer({
storage: multerS3({
    s3: minioClient,
    bucket: bucketName,
    key: function (req, file, cb) {
    cb(null, file.originalname);
    },
}),
});
  
///////////////////////////////////////////////
/// Get posted data as an async function
//
const getPostedData = async (req, res) => {
try {
    let s3URLs = await listObjects(req, res);
    const fname = req.files[0].originalname;
    var s3URL = "URL not generated due to technical issue.";
    for (let i = 0; i < s3URLs.length; i++) {
    if (s3URLs[i].includes(fname)) {
        s3URL = s3URLs[i];
        break;
    }
    }
    res.write("Successfully uploaded " + req.files.length + " files!");

    // Use this code to retrieve the value entered in the username field in the index.html
    var username = req.body["name"];
    // Use this code to retrieve the value entered in the email field in the index.html
    var email = req.body["email"];
    // Use this code to retrieve the value entered in the phone field in the index.html
    var phone = req.body["phone"];
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
const getImagesFromS3Bucket = async (req, res) => {
try {
    let imageURL = await listObjects(req, res);
    console.log("ImageURL:", imageURL);
    res.set("Content-Type", "text/html");
    res.write("<div>Welcome to the gallery" + "</div>");
    for (let i = 0; i < imageURL.length; i++) {
    res.write('<div><img src="' + imageURL[i] + '" /></div>');
    }
    res.end();
} catch (err) {
    console.error(err);
}
};

////////////////////////////////////////////////
// Lookup Database Identifier
//
const getDBIdentifier = async () => {
const client = new RDSClient({ region: "us-east-2" });
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
    const mysql = require("mysql2/promise");
    // create the connection to database
    const connection = await mysql.createConnection({
    host: dbIdentifier.DBInstances[0].Endpoint.Address,
    user: obj.username,
    password: obj.password,
    database: "company",
    });

    // simple query
    const [rows, fields] = await connection.execute("SELECT * FROM `entries`");
    return rows;
} catch (err) {
    console.error(err);
}
};

const row = (html) => `<tr>\n${html}</tr>\n`,
heading = (object) =>
    row(
    Object.keys(object).reduce(
        (html, heading) => html + `<th>${heading}</th>`,
        ""
    )
    ),
datarow = (object) =>
    row(
    Object.values(object).reduce(
        (html, value) => html + `<td>${value}</td>`,
        ""
    )
    );

function htmlTable(dataList) {
return `<table>
                ${heading(dataList[0])}
                ${dataList.reduce(
                    (html, object) => html + datarow(object),
                    ""
                )}
                </table>`;
}

////////////////////////////////////////////////
// Select and Print Record
//
const selectAndPrintRecord = async (req, res) => {
let dbIdentifier = await getDBIdentifier();
let sec = await getSecrets();
let obj = JSON.parse(sec.SecretString);
try {
    const mysql = require("mysql2/promise");
    // create the connection to database
    const connection = await mysql.createConnection({
    host: dbIdentifier.DBInstances[0].Endpoint.Address,
    user: obj.username,
    password: obj.password,
    database: "company",
    });

    // simple query
    const [rows, fields] = await connection.execute("SELECT * FROM `entries`");
    res.set("Content-Type", "text/html");
    res.write("Here are the records: " + "\n");
    res.write(htmlTable(rows));
    res.end();
    return rows;
} catch (err) {
    console.error(err);
}
};

////////////////////////////////////////////////
// Select and Print Record
//
const insertRecord = async (req, res) => {
let dbIdentifier = await getDBIdentifier();
let sec = await getSecrets();
let obj = JSON.parse(sec.SecretString);
try {
    // console.error("Secret1:", obj.password);
    // console.error("Secret2:", obj.username);
    // console.error("dbIdentifier:", dbIdentifier.DBInstances[0].Endpoint.Address);
    const mysql = require("mysql2/promise");
    // create the connection to database
    const connection = await mysql.createConnection({
    host: dbIdentifier.DBInstances[0].Endpoint.Address,
    user: obj.username,
    password: obj.password,
    database: "company",
    });

    // simple query
    let email = req.body["email"];
    let id = uuidv4();
    let username = req.body["name"];
    let phone = req.body["phone"];
    let s3URLs = await listObjects(req, res);
    const fname = req.files[0].originalname;
    var s3URL = "URL not generated due to technical issue.";
    for (let i = 0; i < s3URLs.length; i++) {
    if (s3URLs[i].includes(fname)) {
        s3URL = s3URLs[i];
        break;
    }
    }
    let statement =
    'INSERT INTO entries(RecordNumber,CustomerName,Email,Phone,Stat,RAWS3URL) VALUES("' +
    id +
    '","' +
    username +
    '","' +
    email +
    '","' +
    phone +
    '",1,"' +
    s3URL +
    '");';
    const [rows, fields] = await connection.execute(statement);
    //    console.error(rows);
    return rows;
} catch (err) {
    console.error(err);
}
};

////////////////////////////////////////////////////////////////////////////////
// Request to index.html or / express will match this route and render this page
//

app.get("/", function (req, res) {
res.sendFile(path.join(__dirname , "index.html"));
});

app.get("/gallery", function (req, res) {
(async () => {
    await getImagesFromS3Bucket(req, res);
})();
});

app.get("/db", function (req, res) {
(async () => {
    await getDBIdentifier();
})();
(async () => {
    await selectAndPrintRecord(req, res);
})();
});

app.post("/upload", upload.array("uploadFile", 1), function (req, res, next) {
(async () => {
    await getPostedData(req, res);
})();

(async () => {
    await insertRecord(req, res);
})();
});

app.listen(3000, function () {
console.log("Min.io s3 file upload app listening on port 3000");
});
