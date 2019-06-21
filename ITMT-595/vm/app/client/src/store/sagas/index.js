import { takeLatest } from 'redux-saga/effects';
import * as actionTypes from '../actions/actionTypes';
import * as authSaga from './authSaga';
import * as listingsSaga from './listingsSaga';
import * as adminSaga from './adminSaga';

export function* watchAuth() {
  yield takeLatest(actionTypes.USER_LOAD_INIT, authSaga.loadUserSaga);
  yield takeLatest(actionTypes.LOGIN_INIT, authSaga.loginUserSaga);
  yield takeLatest(actionTypes.REGISTER_INIT, authSaga.registerUserSaga);
  yield takeLatest(actionTypes.GET_USER_INIT, authSaga.getUserSaga);
  yield takeLatest(actionTypes.UPDATE_USER_INIT, authSaga.updateUserSaga);
  yield takeLatest(actionTypes.DELETE_USER_INIT, authSaga.deleteUserSaga);
}

export function* watchListings() {
  yield takeLatest(
    actionTypes.GET_LISTINGS_INIT,
    listingsSaga.loadListingsSaga
  );
  yield takeLatest(actionTypes.ADD_LISTING_INIT, listingsSaga.addListingSaga);
  yield takeLatest(actionTypes.GET_LISTING_INIT, listingsSaga.getListingSaga);
  yield takeLatest(
    actionTypes.DELETE_LISTING_INIT,
    listingsSaga.deleteListingSaga
  );
  yield takeLatest(
    actionTypes.UPDATE_LISTING_INIT,
    listingsSaga.updateListingSaga
  );
}

export function* watchAdmin() {
  yield takeLatest(actionTypes.GET_USERS_INIT, adminSaga.loadUsersSaga);
  yield takeLatest(
    actionTypes.DELETE_LISTINGS_INIT,
    adminSaga.deleteListingsSaga
  );
  yield takeLatest(actionTypes.DELETE_USERS_INIT, adminSaga.deleteUsersSaga);
}
