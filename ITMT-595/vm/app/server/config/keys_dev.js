const dotenvJSON = require("dotenv-json");
dotenvJSON({ path: "../../packer/vanilla-install/variables.json" });

module.exports = {
  mongoURI: process.env["database-development-connection"],
  nginxIP: process.env["nginx-web-server-ip"],
  mongodbIP: process.env["database-ip"],
  webAddress: "localhost",
  jwtSecret: process.env["jwt-secret"],
  redisPassword: process.env["redis-server-password"],
  redisIp: process.env["redis-server-ip"],
  redisPort: process.env["redis-server-port"],
  cloudinaryCloudName: process.env["cloudinary-cloud-name"],
  cloudinaryApiKey: process.env["cloudinary-api-key"],
  cloudinaryApiSecret: process.env["cloudinary-api-secret"]
};

console.log("[NODE_ENV] = Development");
