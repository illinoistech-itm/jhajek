const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');

// Load Model
const User = require('../../models/User');
const Listing = require('../../models/Listing');

// @route   GET api/user/test
// @desc    Tests user route
// @access  Public
router.get('/test', (req, res) => {
  res.json({
    msg: 'User works'
  });
});
// @route   GET api/user/:id
// @desc    GET user
// @access  Private
router.get('/:id', auth, (req, res) => {
  User.findById(req.params.id)
    .then(user => {
      if (!user) throw error;
      user = user._doc;
      delete user.password;

      res.status(200).json({ user });
    })
    .catch(error => {
      return res.status(404).json({
        errors: [{ message: "User don't exist" }]
      });
    });
});

// @route   PUT api/user/:id
// @desc    Update user
// @access  Private
router.put('/:id', auth, (req, res) => {
  let admin = false;

  User.findById(req.params.id)
    .then(user => {
      if (!user) {
        throw error;
      }
      let { roles } = req.user;
      let role = roles.find(role => role === 'admin');
      if (role === 'admin') {
        return (admin = true);
      } else {
        return (admin = false);
      }
    })
    .then(admin => {
      // Check User param id versus user logged in

      if (req.user.id != req.params.id && !admin) {
        return res.status(401).json({
          errors: [{ message: 'Not authorized' }]
        });
      }

      User.findByIdAndUpdate(req.params.id, { $set: req.body }).then(user => {
        res.status(200).json(user);
      });
    })
    .catch(error => {
      return res.status(404).json({
        errors: [{ message: "User don't exist" }]
      });
    });
});

// @route   DELETE api/user/:id
// @desc    Delete user
// @access  Private
router.delete('/:id', auth, (req, res) => {
  let admin = false;

  User.findById(req.user.id)
    .then(user => {
      let { roles } = user;
      let role = roles.find(role => role === 'admin');
      if (role === 'admin') {
        return (admin = true);
      } else {
        return (admin = false);
      }
    })
    .then(admin => {
      // Check User param id versus user logged in
      if (req.user.id != req.params.id && !admin) {
        return res.status(401).json({
          errors: [{ message: 'Not authorized' }]
        });
      }

      User.findByIdAndRemove(req.params.id).then(user =>
        res.status(200).json(user)
      );
    })
    .catch(error => {
      return res.status(404).json({
        errors: [{ message: "User don't exist" }]
      });
    });
});

// @route   GET api/user/listings
// @desc    Get all listing for user
// @access  Private
router.get('/:id/listings', auth, (req, res) => {
  Listing.find({ seller: req.params.id })
    .then(listing => {
      return res.status(200).json(listing);
    })
    .catch(error =>
      res.status(400).json({
        errors: [{ message: "User don't exist" }]
      })
    );
});
module.exports = router;
