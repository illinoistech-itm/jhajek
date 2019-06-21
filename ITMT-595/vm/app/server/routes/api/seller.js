const express = require("express");
const router = express.Router();
// const passport = require("passport");

// Load Model
const Seller = require("../../models/Seller");

// // Load Validation
// const validatePostInput = require("../../validation/post");

// @route   GET api/seller/test
// @desc    Tests seller route
// @access  Public
router.get("/test", (req, res) => {
  res.json({
    msg: "Seller works"
  });
});

module.exports = router;
