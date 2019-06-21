const mongoose = require('mongoose');
const path = require('path');
const bodyParser = require('body-parser');
const express = require('express'),
  http = require('http'),
  app = express(),
  server = http.createServer(app);
const redis = require('redis');
const cors = require('cors');
const bcrypt = require('bcryptjs');

// Load routes files
const buyer = require('./routes/api/buyer');
const listings = require('./routes/api/listings');
const seller = require('./routes/api/seller');
const user = require('./routes/api/user');
const auth = require('./routes/api/auth');
const admin = require('./routes/api/admin');

// Load Keys
const keys = require('./config/keys');

let webServerPort = keys.webServerPort || 5000;
let webAddress = keys.webAddress;

// Body-Parser Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

if (process.env.NODE_ENV == 'development') {
  app.use(cors());
}

// MongoDB connection
mongoose
  .connect(keys.mongoURI, { useNewUrlParser: true, useFindAndModify: false })
  .then(() => {
    console.log('[MONGODB]: MongoDB Connected');
  })
  .catch(error => {
    console.log('[MONGODB]:', error);
  });

// Redis caching server connection
const redisClient = redis.createClient({
  host: keys.redisIp,
  port: keys.port
});

redisClient.auth(keys.redisPassword, (error, reply) => {
  if (error) console.log(error);
  reply === 'OK'
    ? console.log('[REDIS]: Redis connection authenticated')
    : console.log('[REDIS]: Redis connection not authenticated');
});

redisClient.on('ready', () => {
  console.log('[REDIS]: Redis is ready');
});

redisClient.on('error', () => {
  console.log('[REDIS]: Error in Redis');
});

// Test Users
const User = require('./models/User');
if (process.env.NODE_ENV === 'production') {
  for (let i = 0; i <= 15; i++) {
    let user;

    if (i === 1) {
      user = new User({
        email: 'admin',
        password: 'admin',
        firstName: `admin`,
        lastName: `admin`,
        phoneNumber: `000-000-0000`,
        bio: `My bio : admin`,
        roles: ['admin']
      });
    } else {
      user = new User({
        email: `testuser${i}@gmail.com`,
        password: 'password',
        firstName: `TestuserFirstname${i}`,
        lastName: `TestuserLastname${i}`,
        phoneNumber: `${i}23-444-5555`,
        bio: `My bio ${i}`,
        roles: i % 2 ? ['seller'] : ['buyer']
      });
    }

    bcrypt.genSalt(10, (error, salt) => {
      bcrypt.hash(user.password, salt, (error, hash) => {
        if (error) {
          throw error;
        }
        user.password = hash;
      });
    });

    User.find({ email: user.email }).then(foundUser => {
      if (foundUser.length === 0) {
        // Save New User with Hashed Password
        user.save();
      }
    });
  }
}

// Use Routes
app.use('/api/buyer', buyer);
app.use('/api/listings', listings);
app.use('/api/seller', seller);
app.use('/api/user', user);
app.use('/api/auth', auth);
app.use('/api/admin', admin);

// Server Static Assets if in production
if (process.env.NODE_ENV === 'production') {
  // Set static folder
  app.use(express.static('../client/build'));

  app.get('*', (req, res) => {
    res.sendFile(path.resolve(__dirname, '../client', 'build', 'index.html'));
  });
}

server.listen(webServerPort, webAddress, () => {
  console.log(
    '[EXPRESS]: Server running at: ' + webAddress + ':' + webServerPort
  );
});
