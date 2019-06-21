const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const UserSchema = new Schema({
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  phoneNumber: {
    type: String,
    required: true,
  },
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  roles: [
    {
      type: String,
      required: true,
    },
  ],
  bio: {
    type: String,
  },
  roommates: [
    {
      type: Schema.Types.ObjectId,
      ref: 'buyer',
    },
  ],
  favListings: [
    {
      type: Schema.Types.ObjectId,
      ref: 'listing',
    },
  ],
  registeredDate: {
    type: Date,
    default: Date.now,
  },
});

const UserModel = mongoose.model('user', UserSchema);

module.exports = UserModel;
