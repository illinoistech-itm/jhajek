import React from 'react';
import { connect } from 'react-redux';
import * as actionTypes from '../../store/actions/actionTypes';
import { Redirect } from 'react-router-dom';

function LogoutPage(props) {
  props.logout();
  return <Redirect to="/" />;
}

const mapDispatchToProps = dispatch => {
  return {
    logout: () => dispatch({ type: actionTypes.LOGOUT_SUCCESS })
  };
};

export default connect(
  null,
  mapDispatchToProps
)(LogoutPage);
