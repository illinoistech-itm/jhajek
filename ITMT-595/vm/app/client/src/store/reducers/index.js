import { combineReducers } from 'redux';
import errorsReducer from './errorsReducer';
import authReducer from './authReducer';
import listingsReducer from './listingsReducer';
import usersReducer from './usersReducer';

export default combineReducers({
  errors: errorsReducer,
  auth: authReducer,
  listings: listingsReducer,
  users: usersReducer
});
