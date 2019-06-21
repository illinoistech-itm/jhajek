import * as actionTypes from '../actions/actionTypes';

const initialState = {
  users: [],
  viewingUser: {}
};

const getUsers = (state, action) => {
  state = {
    ...state,
    users: action.payload.users
  };
  return state;
};

const getUser = (state, action) => {
  state = {
    ...state,
    viewingUser: action.payload.user
  };
  return state;
};

const clearUser = (state, action) => {
  state = {
    ...state,
    viewingUser: {}
  };
  return state;
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case actionTypes.GET_USERS_SUCCESS:
      return getUsers(state, action);
    case actionTypes.GET_USER_SUCCESS:
      return getUser(state, action);
    case actionTypes.CLEAR_USER:
      return clearUser(state, action);
    default:
      return state;
  }
};

export default reducer;
