import * as actionTypes from '../actions/actionTypes';

const initialState = {
  token: localStorage.getItem('token'),
  isAuthenticated: null,
  isLoading: null,
  user: null,
  done: false
};

const userLoading = (state, action) => {
  state = {
    ...state,
    isLoading: true
  };
  return state;
};

const userLoaded = (state, action) => {
  state = {
    ...state,
    isLoading: false,
    isAuthenticated: true,
    user: action.payload.user
  };
  return state;
};

const setUserAuthentication = (state, action) => {
  localStorage.setItem('token', action.payload.token);
  state = {
    ...state,
    isLoading: false,
    isAuthenticated: true,
    user: action.payload.user,
    token: action.payload.token,
    done: true
  };
  return state;
};

const resetAuthentication = (state, action) => {
  localStorage.removeItem('token');
  state = {
    ...state,
    token: null,
    user: null,
    isAuthenticated: false,
    isLoading: false,
    done: true
  };

  return state;
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.USER_LOADING:
      return userLoading(state, action);
    case actionTypes.USER_LOADED:
      return userLoaded(state, action);
    case actionTypes.LOGIN_SUCCESS:
    case actionTypes.REGISTER_SUCCESS:
      return setUserAuthentication(state, action);
    case actionTypes.AUTH_ERROR:
    case actionTypes.LOGIN_FAIL:
    case actionTypes.LOGOUT_SUCCESS:
    case actionTypes.REGISTER_FAIL:
    case actionTypes.DELETE_USER_SUCCESS:
      return resetAuthentication(state, action);
    default:
      return state;
  }
};

export default reducer;
