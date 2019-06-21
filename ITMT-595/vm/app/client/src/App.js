import React, { Component } from 'react';
import Layout from './Layout/';
import { CssBaseline } from '@material-ui/core';
import theme from './App.MuiTheme';
import { MuiThemeProvider } from '@material-ui/core/styles';
import { connect } from 'react-redux';
import * as actions from './store/actions';
import { BrowserRouter } from 'react-router-dom';

// console.log(theme);

class App extends Component {
  componentDidMount() {
    this.props.loadUser();
  }

  render() {
    const { auth, errors, clearErrors } = this.props;
    let renderedComp = '';

    if (auth.done) {
      renderedComp = (
        <Layout auth={auth} errors={errors} clearErrors={clearErrors} />
      );
    }

    return (
      <MuiThemeProvider theme={theme}>
        <CssBaseline />
        <BrowserRouter>{renderedComp}</BrowserRouter>
      </MuiThemeProvider>
    );
  }
}

const mapStateToProps = state => {
  return {
    auth: state.auth,
    errors: state.errors.errors
  };
};

const mapDispatchToProps = dispatch => {
  return {
    loadUser: () => dispatch(actions.loadUserInit()),
    clearErrors: () => dispatch(actions.clearErrors())
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(App);
