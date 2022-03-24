const express = require('express');

var app = express();
var fs = require('fs'); //for reading the filesystem
const https = require('https')
var hskey = fs.readFileSync('/etc/ssl/private/expressjs-selfsigned.key');
var hscert = fs.readFileSync('/etc/ssl/certs/expressjs-selfsigned.crt')

var options = {
  key: hskey,
  cert: hscert
};
// launch the https server
https.createServer(options, app).listen(8080)
// log requests
app.use(logger('dev'));

// express on its own has no notion
// of a "file". The express.static()
// middleware checks for a file matching
// the `req.path` within the directory
// that you pass it. In this case "GET /js/app.js"
// will look for "./public/js/app.js".

app.use(express.static(path.join(__dirname, 'public')));

// if you wanted to "prefix" you may use
// the mounting feature of Connect, for example
// "GET /static/js/app.js" instead of "GET /js/app.js".
// The mount-path "/static" is simply removed before
// passing control to the express.static() middleware,
// thus it serves the file correctly by ignoring "/static"
app.use('/static', express.static(path.join(__dirname, 'public')));

app.get('/about', (req,res) => {
    res.sendFile('about.html', { root: 'public' });
});

app.get('/questions', (req,res) => {
    res.sendFile('questions.html', { root: 'public' });
});
app.get('/user', (req,res) => {
    res.sendFile('user.html', { root: 'public' });
});

app.listen(8080);
console.log('listening on port 8080');
console.log('try:');
console.log('  GET /hello.txt');
console.log('  GET /js/app.js');
console.log('  GET /css/style.css');