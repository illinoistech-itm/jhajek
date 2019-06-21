const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const SellerSchema = new Schema({
  sellerInfo: {
    type: Schema.Types.ObjectId,
    ref: 'user',
  },
  date: { type: Date, default: Date.now },
});

const SellerModel = mongoose.model('seller', SellerSchema);

module.exports = SellerModel;
