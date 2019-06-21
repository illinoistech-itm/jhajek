const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const keys = require('../../config/keys');
const auth = require('../../middleware/auth');
const errorsFormatter = require('../../helperFunctions/errorsFormatter');

// Load Model
const User = require('../../models/User');

// @route   GET api/auth/test
// @desc    Tests auth route
// @access  Public
router.get('/test', (req, res) => {
  res.json({
    msg: 'Auth works',
  });
});

// Login route
router.post('/', (req, res) => {
  User.findOne({ email: req.body.email }).then((user) => {
    if (!user)
      return res
        .status(400)
        .json({ errors: [{ message: 'Email and/or password is incorrect.' }] });

    // Compare Password with Bcryptjs Hashed
    bcrypt.compare(req.body.password, user.password).then((isMatch) => {
      if (!isMatch)
        return res.status(400).json({
          errors: [{ message: 'Email and/or password is incorrect.' }],
        });

      // Remove user password from user object
      user = {
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        roles: user.roles
      };

      // Create json web token: payload is new user
      jwt.sign(user, keys.jwtSecret, { expiresIn: '3d' }, (error, token) => {
        // Once jwt is signed, run code
        if (error) throw error;
        res.json({ token: token, user });
      });
    });
  });
});

// @route   GET api/auth/user
// @desc    Get User route
// @access  Private
router.get('/user', auth, (req, res) => {
  User.findById(req.user.id)
    .select('-password')
    .then((user) => {
      res.json(user);
    })
});

// @route   POST api/auth/user/
// @desc    Create user account
// @access  Public
router.post('/user', (req, res) => {
  User.findOne({ email: req.body.email }).then((user) => {
    if (!user) return;
    res.status(409).json({ errors: [{ message: 'User already exits' }] });
  });

  let = newUser = new User(req.body);  
  let err = newUser.validateSync()

  if (err) {
    const errors = errorsFormatter(err);
    return res.status(400).json({ errors: [{ message: 'All user fields must be entered' }] });
  }
  

  // Hash Password with Bcryptjs
  bcrypt.genSalt(10, (error, salt) => {
    bcrypt.hash(newUser.password, salt, (error, hash) => {
      if (error) {
        throw error;
      }
      newUser.password = hash;

      // Save New User with Hashed Password
      newUser
        .save()
        .then((user) => {
          // Takes password out of user object
          const { password, ...formattedUserObj } = user._doc;
          user = formattedUserObj;

          // Create json web token: payload is new user
          jwt.sign(
            user,
            keys.jwtSecret,
            { expiresIn: '1d' },
            (error, token) => {
              // Once jwt is signed, run code
              if (error) throw error;
              res.status(200).json({ token: token, user });
            },
          );
        })
        .catch((err) => {
          if (err.errors) {
            const errors = errorsFormatter(err);
            errors.type = "auth"
            return res.status(400).json({ errors: errors });
          } else {
            console.log(err);
          }
        });
    });
  });
});

module.exports = router;
