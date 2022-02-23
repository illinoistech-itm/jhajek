// server.js
const express = require('express');
// Define Express App
const app = express();
const PORT = process.env.PORT || 8080;
// Serve Static Assets
app.use(express.static('public'));
app.use('/static', express.static('public'))

app.get('/about', (req,res) => {
    res.sendFile('about.html', { root: 'public' });
});

app.get('/questions', (req,res) => {
    res.sendFile('questions.html', { root: 'public' });
});
app.get('/user', (req,res) => {
    res.sendFile('user.html', { root: 'public' });
});

// Samples @ http://expressjs.com/en/starter/examples.html
app.listen(PORT, () => {
  console.log('Server connected at:',PORT);
});
