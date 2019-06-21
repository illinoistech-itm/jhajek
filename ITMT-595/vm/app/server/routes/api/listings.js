const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');
const errorsFormatter = require('../../helperFunctions/errorsFormatter');
const parser = require('../../services/cloudinary.service');

// Load Model
const Listing = require('../../models/Listing');
const User = require('../../models/User');

// @route   GET api/listing/test
// @desc    Tests user route
// @access  Public
router.get('/test', (req, res) => {
  res.json({
    msg: 'Listing works'
  });
});

// @route   GET api/listings/
// @desc    Get all listing by every user
// @access  Private
router.get('/', auth, (req, res) => {
  Listing.find()
    .then(listings => {
      return res.json(listings);
    })
    .catch(error =>
      res.json({
        errors: [{ message: 'Error retrieving listings.' }]
      })
    );
});

// @route   POST api/listing/
// @desc    Create new listing
// @access  Private
router.post('/', auth, (req, res) => {
  // Pull values from req body into Listing Model format
  let newListing = new Listing(req.body);
  newListing.seller = req.user.id;

  Listing.find({ address: newListing.address })
    .then(listing => {
      if (listing.length > 0) {
        throw err;
      }

      // Save new listing to database
      newListing
        .save()
        .then(listing => res.status(200).json(listing))
        .catch(err => {
          if (err.errors) {
            const errors = errorsFormatter(err);
            errors.type = 'listing';

            res.status(409).json({
              errors: [{ message: 'Listing fields must be completed' }]
            });
          } else {
            console.log(err);
          }
        });
    })
    .catch(err => {
      return res
        .status(409)
        .json({ errors: { message: 'Listing with address already exist.' } });
    });
});

// @route   PUT api/listings/:id
// @desc    Update listing for user
// @access  Private
router.put('/:id', auth, parser.array('photos'), async (req, res) => {
  if (req.files.length > 0) {
    req.body.photos = await req.files.map(photo => {
      return {
        url: photo.url,
        secureUrl: photo.secure_url,
        originalName: photo.originalname
      };
    });
  }
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
      Listing.findById(req.params.id)
        .then(listing => {
          // Check seller listing versus user logged in
          if (req.user.id != listing.seller && !admin) {
            return res.status(401).json({
              errors: [{ message: 'Not authorized' }]
            });
          }

          // Update listing
          Listing.findByIdAndUpdate(req.params.id, { $set: req.body }).then(
            listing => res.status(200).json(listing)
          );

          // // Update listing
          // Listing.findByIdAndUpdate(req.params.id, { $set: req.body }).then(
          //   listing => {
          //     Listing.findById(listing._id).then(listing =>
          //       res.status(200).json(listing)
          //     );
          //   }
          // );

          // return res.json(listing);
        })
        .catch(error =>
          res.status(404).json({
            errors: [{ message: "Listing doesn't exist." }]
          })
        );
    });
});

// @route   DELETE api/listing/:id
// @desc    Delete listing for user
// @access  Private
router.delete('/:id', auth, (req, res) => {
  Listing.findById(req.params.id)
    .then(listing => {
      // Check seller listing versus user logged in
      if (req.user.id != listing.seller) {
        return res.status(401).json({
          errors: [{ message: 'Not authorized' }]
        });
      }

      // Update listing
      Listing.findByIdAndRemove(req.params.id).then(listing =>
        res.status(200).json(listing)
      );

      // return res.json(listing);
    })
    .catch(error =>
      res.status(404).json({
        errors: [{ message: "Listing doesn't exist." }]
      })
    );
});

// @route   GET api/listing/:id
// @desc    Get all listing for user
// @access  Private
router.get('/:id', auth, (req, res) => {
  Listing.findById(req.params.id)
    .then(listing => {
      res.status(200).json(listing);
    })
    .catch(error =>
      res.status(404).json({
        errors: [{ message: 'Listing does not exist.' }]
      })
    );
});

module.exports = router;
