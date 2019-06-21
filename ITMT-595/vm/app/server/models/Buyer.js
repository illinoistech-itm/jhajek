const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BuyerSchema = new Schema({
  user: {
    type: Schema.Types.ObjectId,
    ref: "user"
  },
  roommate: {
    type: Schema.Types.ObjectId,
    ref: "user"
  },
  preferences: {
    1: {
      type: Boolean,
      default: false
    },
    2: {
      type: Boolean,
      default: false
    },
    3: {
      type: Boolean,
      default: false
    }
  },
  phoneNumber: {
    type: String
  },
  firstName: {
    type: String,
    required: true
  },
  lastName: {
    type: String,
    required: true
  },
  date: { type: Date, default: Date.now }
});

module.exports = Buyer = mongoose.model("buyer", BuyerSchema);
