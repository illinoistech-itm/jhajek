const keys = require("../config/keys");
const jwt = require("jsonwebtoken");

const auth = (req, res, next) => {
  const token = req.header("x-auth-token");

  // Check for token
  if (!token) {
    return res
      .status(401)
      .json({ errors: [{ message: "User is un authorized" }] });
  }

  try {
    // Verify token
    const decoded = jwt.verify(token, keys.jwtSecret);
    // Add user from jwt payload
    req.user = decoded;

    if (req.user._id) {
      req.user.id = req.user._id;
      delete req.user._id;
    }

    next();
  } catch (error) {
    return res
      .status(401)
      .json({ errors: [{ message: "Token is unauthorized" }] });
  }
};

module.exports = auth;
