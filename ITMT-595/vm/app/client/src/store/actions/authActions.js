import * as actionTypes from './actionTypes';

// Check token and load user
export const loadUserInit = () => {
  return {
    type: actionTypes.USER_LOAD_INIT
  };
};

export const loadUserSuccess = () => {
  return {
    type: actionTypes.USER_LOADED
  };
};

export const loginInit = (user, history) => {
  return {
    type: actionTypes.LOGIN_INIT,
    payload: { user: user, history: history }
  };
};

export const loginSuccess = (token, user) => {
  return {
    type: actionTypes.LOGIN_SUCCESS,
    payload: { token: token, user: user }
  };
};

export const registerInit = (user, history) => {
  return {
    type: actionTypes.REGISTER_INIT,
    payload: { user: user, history: history }
  };
};

export const getUserInit = id => {
  return {
    type: actionTypes.GET_USER_INIT,
    payload: { id: id }
  };
};

export const getUserSuccess = user => {
  return {
    type: actionTypes.GET_USER_SUCCESS,
    payload: { user: user }
  };
};

export const clearUSer = () => {
  return {
    type: actionTypes.CLEAR_USER
  };
};

export const registerSuccess = (token, user) => {
  return {
    type: actionTypes.LOGIN_SUCCESS,
    payload: { token: token, user: user }
  };
};

export const updateUserInit = (id, updatedUser) => {
  return {
    type: actionTypes.UPDATE_USER_INIT,
    payload: { id: id, updatedUser }
  };
};

export const updateUserSuccess = () => {
  return {
    type: actionTypes.GET_USERS_INIT
  };
};

export const deleteUserInit = id => {
  return {
    type: actionTypes.DELETE_USER_INIT,
    payload: { id: id }
  };
};

export const deleteUserSuccess = () => {
  return {
    type: actionTypes.GET_USERS_INIT
  };
};
