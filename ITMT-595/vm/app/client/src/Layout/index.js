import React, { Component } from 'react';
import IndexPage from '../Pages/IndexPage';
import LoginPage from '../Pages/LoginPage';
import SignupPage from '../Pages/SignupPage';
import CreateListingPage from '../Pages/CreateListingPage';
import AdminPage from '../Pages/AdminPage';
import HomePage from '../Pages/HomePage';
import LogoutPage from '../Pages/LogoutPage';
import { Route, Switch, Redirect } from 'react-router-dom';
import ProtectedRoute from '../hoc/ProtectedRoute';
import { withStyles } from '@material-ui/core/styles';
import Snackbar from '../components/UI/Snackbar/Snackbar';

const styles = theme => ({
  root: {
    minHeight: '100vh'
  }
});

class Layout extends Component {
  state = {
    showSnackbar: false
  };
  componentWillReceiveProps(nextProps) {
    console.log(nextProps.errors.length > 1);

    if (nextProps.errors.length > 0) {
      this.setState({
        showSnackbar: true
      });
    }
  }

  onSnackbarOpen = () => {
    this.setState({ showSnackbar: true });
    setTimeout(this.onSnackbarClose, 6000);
  };

  onSnackbarClose = () => {
    this.setState({ showSnackbar: false });
    this.props.clearErrors();
  };

  render() {
    const { classes, auth, errors } = this.props;
    const { showSnackbar } = this.state;
    const { isAuthenticated } = auth;

    let snackbarConfig = {
      onSnackBarClose: this.onSnackbarClose,
      onSnackBarOpen: this.onSnackbarOpen,
      showSnackbar: showSnackbar
    };

    if (errors.length > 0) {
      snackbarConfig.message = errors[0].message;
    }

    return (
      <div className={classes.root}>
        {auth.done && <Snackbar snackbarConfig={snackbarConfig} />}
        <Switch>
          <Route
            path="/"
            exact
            component={props =>
              isAuthenticated ? (
                <Redirect to="/home" />
              ) : (
                <IndexPage {...props} />
              )
            }
          />
          <Route path="/login" component={LoginPage} />
          <Route path="/signup" component={SignupPage} />
          <ProtectedRoute
            path="/createListing"
            component={CreateListingPage}
            isAuthenticated={isAuthenticated}
          />
          <ProtectedRoute
            path="/admin"
            component={AdminPage}
            isAuthenticated={isAuthenticated}
          />
          <ProtectedRoute
            path="/home"
            component={HomePage}
            isAuthenticated={isAuthenticated}
          />
          <ProtectedRoute
            path="/logout"
            component={LogoutPage}
            isAuthenticated={isAuthenticated}
          />
          <Route path="/" component={() => <Redirect to="/" />} />
        </Switch>
      </div>
    );
  }
}

export default withStyles(styles)(Layout);
