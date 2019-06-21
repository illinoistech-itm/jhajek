import * as actionTypes from './actionTypes';

// Get all listings
export const getListingsInit = () => {
  return {
    type: actionTypes.GET_LISTINGS_INIT
  };
};

// Get all listings success
export const getListingsSuccess = listings => {
  return {
    type: actionTypes.GET_LISTINGS_SUCCESS,
    payload: { listings: listings }
  };
};

// Add listing
export const addListingInit = (listing, history) => {
  return {
    type: actionTypes.ADD_LISTING_INIT,
    payload: { listing: listing, history: history }
  };
};

// Get all listing success
export const addListingSuccess = () => {
  return {
    type: actionTypes.GET_LISTINGS_INIT
  };
};

// Get single listing
export const getListingInit = id => {
  return {
    type: actionTypes.GET_LISTING_INIT,
    payload: { id: id }
  };
};

// Get single listing success
export const getListingSuccess = listing => {
  return {
    type: actionTypes.GET_LISTING_SUCCESS,
    payload: { listing: listing }
  };
};

// Clear listing
export const clearListing = () => {
  return {
    type: actionTypes.CLEAR_LISTING
  };
};

// Delete single listing
export const deleteListingInit = id => {
  return {
    type: actionTypes.DELETE_LISTING_INIT,
    payload: { id: id }
  };
};

// Delete single listing success
export const deleteListingSuccess = () => {
  return {
    type: actionTypes.GET_LISTINGS_INIT
  };
};

// Update single listing
export const updateListingInit = (id, updatedListing) => {
  console.log(id);

  return {
    type: actionTypes.UPDATE_LISTING_INIT,
    payload: { id: id, updatedListing: updatedListing }
  };
};

// Update single listing success
export const updateListingSuccess = () => {
  return {
    type: actionTypes.GET_LISTINGS_INIT
  };
};
