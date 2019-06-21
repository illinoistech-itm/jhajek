import { put } from 'redux-saga/effects';
import axiosInstance from '../../axiosConfig';
import * as actions from '../actions';
import store from '../../store';

export async function tokenConfig() {
  const state = await store.getState();

  // Get token from storage
  const token = state.auth.token;
  // Headers
  const config = {
    headers: {
      'Content-type': 'application/json'
    }
  };

  // If token then add to headers
  if (token) {
    config.headers['x-auth-token'] = token;
  }

  return config;
}

export function* deleteListingsSaga(action) {
  const config = yield tokenConfig();

  try {
    yield axiosInstance.delete('/api/admin/listings', config);
    yield put(actions.deleteListingsSuccess());
  } catch (error) {
    yield put(actions.getErrors({ message: 'No listings' }));
  }
}

export function* deleteUsersSaga(action) {
  const config = yield tokenConfig();

  try {
    yield axiosInstance.delete('/api/admin/users', config);
    yield put(actions.deleteUsersSuccess());
  } catch (error) {
    yield put(actions.getErrors({ message: 'No Users' }));
  }
}

export function* loadUsersSaga(action) {
  const config = yield tokenConfig();

  try {
    const response = yield axiosInstance.get('/api/admin/users', config);
    const users = yield response.data;
    console.log(users);

    yield put(actions.getUsersSuccess(users));
  } catch (error) {
    console.log(error);

    yield put(actions.getErrors(error.response.data.errors));
  }
}
