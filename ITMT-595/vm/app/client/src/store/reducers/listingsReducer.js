import * as actionTypes from '../actions/actionTypes';

const initialState = {
  listings: [],
  viewListing: null
};

const getListings = (state, action) => {
  state = {
    ...state,
    listings: action.payload.listings
  };
  return state;
};

const getListing = (state, action) => {
  state = {
    ...state,
    viewListing: action.payload.listing
  };
  return state;
};

const clearListing = (state, action) => {
  state = {
    ...state,
    viewListing: null
  };
  return state;
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.GET_LISTINGS_SUCCESS:
      return getListings(state, action);
    case actionTypes.GET_LISTING_SUCCESS:
      return getListing(state, action);
    case actionTypes.CLEAR_LISTING:
      return clearListing(state, action);
    default:
      return state;
  }
};

export default reducer;
