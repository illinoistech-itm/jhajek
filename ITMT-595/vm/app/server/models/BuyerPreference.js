const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const BuyerPreferenceSchema = new Schema({
  buyer: {
    type: Schema.Types.ObjectId,
    ref: 'buyer',
  },
  roommatePreferences: {
    amountOfRoommates: {
      type: Boolean,
      default: false,
    },
    victimOfTheft: {
      type: Boolean,
      default: false,
    },
    favoriteWeather: {
      type: String,
      default: false,
    },
    canYouLiveWithPlants: {
      type: Boolean,
      default: false,
    },
    smoker: {
      type: Boolean,
      default: false,
    },
    pets: {
      type: Boolean,
      default: false,
    },
    doYouLikeToRead: {
      type: Boolean,
      default: false,
    },
    housePartyer: {
      type: Boolean,
      default: false,
    },
    openToStranger: {
      type: Boolean,
      default: false,
    },
    openToNewPeople: {
      type: Boolean,
      default: false,
    },
    favColor: {
      type: Boolean,
      default: false,
    },
    openToLearn: {
      type: Boolean,
      default: false,
    },
    isViolenceNecessary: {
      type: Boolean,
      default: false,
    },
    pacifist: {
      type: Boolean,
      default: false,
    },
    handicap: {
      type: Boolean,
      default: false,
    },
    handicapTolerant: {
      type: Boolean,
      default: false,
    },
    needHomeAppliances: {
      type: Boolean,
      default: false,
    },
  },
  propertyPreferences: {
    wifi: {
      type: String,
    },
    heating: {
      type: String,
    },
    cooling: {
      type: String,
    },
    washer: {
      type: String,
    },
    indoorFireplace: {
      type: String,
    },
    typeOfParking: {
      type: String,
    },
    petsAllowed: [
      {
        type: String,
      },
    ],
  },
});

const BuyerPreferenceModel = mongoose.model(
  'buyerPreference',
  BuyerPreferenceSchema,
);

module.exports = BuyerPreferenceModel;
