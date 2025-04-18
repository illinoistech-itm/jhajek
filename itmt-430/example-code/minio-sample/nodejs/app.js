// Install Minio and Multer-s3 packages via the package.json: npm install command
// Minio JavaScript SDK
// https://min.io/docs/minio/linux/developers/javascript/API.html
  
import express from 'express'
const app = express();
import path from 'path'
import { fileURLToPath } from 'url';
import { dirname } from 'path';
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
import multer from 'multer'
import multerS3  from 'multer-s3'
import mysql from 'mysql2/promise'
import 'dotenv/config'
import * as Minio from 'minio'
import * as Fs from 'fs'
var upload = multer({ dest: 'uploads/' })
//////////////////////////////////////////////////////////////////////////////
// Retrieve these values from Vault... I would read them from a .env file
// DotEnv is recommended as the easiest approach 
// https://www.npmjs.com/package/dotenv
// MINIOENDPOINT = "system54.rice.iit.edu"
// You should store the endPoint URL, accessKey and SecretKey values in Vault
// Retrieve them and populate your .env file
// These keys are separate from the Proxmox Keys... more secrets to manage 
//////////////////////////////////////////////////////////////////////////////
const minioClient = new Minio.Client({
    endPoint: process.env.MINIOENDPOINT,
    port: 80,
    useSSL: false,
    accessKey: process.env.MINIOACCESSKEY,
    secretKey: process.env.MINIOSECRETKEY,
  })
//////////////////////////////////////////////////////////////////////////////
//  bucketname is your hawkID - for now we will start with a single bucket per
//  team, but we can create more if needed
//////////////////////////////////////////////////////////////////////////////
// https://www.npmjs.com/package/multer-s3

  
///////////////////////////////////////////////
/// Get posted data as an async function
//
const getPostedData = async (req, res) => {
// Use this code to retrieve the value entered in the bucket field in the index.html
var bucketName = req.body["bucketName"];
try {
    const exists = await minioClient.bucketExists(bucketName)
        if (exists) {
        console.log('Bucket exists.')
        console.log(req.files)
    }
    else {
        await minioClient.makeBucket(bucketName)
        console.log('Bucket created successfully.')
    }
    console.log(req.files[0].originalname)
    console.log(req.files[0].path)
    const fileStream = Fs.createReadStream(req.files[0].path)
    const fileStat = Fs.stat(req.files[0].path, function (err, stats) {
      if (err) {
        return console.log(err)
      }

    const objectURL = minioClient.putObject(bucketName, req.files[0].originalname , fileStream, stats.size, function (err, objInfo) {
        if (err) {
          return console.log(err) // err should be null
        }
        console.log('Success!', objInfo)
      })
    })

    // listObjects
    const stream = minioClient.listObjectsV2(bucketName, '', true, '')
    stream.on('data', function (obj) {
    console.log(obj)
    })
    stream.on('error', function (err) {
    console.log(err)
    })

    // getPresignedURL
    // presigned url for 'getObject' method.
    // expires in a day.
    // Generates a presigned URL for the provided HTTP method, ‘httpMethod’. Browsers/Mobile clients 
    // may point to this URL to directly download objects even if the bucket is private. This 
    // presigned URL can have an associated expiration time in seconds after which the URL is no 
    // longer valid. The default value is 7 days.
    const presignedUrl = await minioClient.presignedUrl('GET', bucketName, req.files[0].originalname, 24 * 60 * 60)
    console.log(presignedUrl)

    // Use this code to retrieve the value entered in the username field in the index.html
    var username = req.body["name"];
    // Use this code to retrieve the value entered in the email field in the index.html
    var email = req.body["email"];
    // Use this code to retrieve the value entered in the phone field in the index.html
    var phone = req.body["phone"];

    // Write output to the screen
    res.write(username + "\n");
    res.write(presignedUrl + "\n");
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
    console.log("Getting Images from minio...");
    res.end();
} catch (err) {
    console.error(err);
}
};

////////////////////////////////////////////////
// Lookup Database Identifier
//
const getDBIdentifier = async () => {
try {
   console.log("getting DB...")
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

app.post("/upload", upload.array('uploadFile', 12), function (req, res, next) {
(async () => {
    await getPostedData(req, res);
})();
/*
(async () => {
    await insertRecord(req, res);
})();*/
});

app.listen(3000, function () {
console.log("Min.io s3 file upload app listening on port 3000");
});
