import React, { Component } from 'react';
import AppBar from '../components/UI/AppBar';
import Drawer from '../components/UI/Drawer';
import { withStyles } from '@material-ui/core/styles';
import { connect } from 'react-redux';

const styles = theme => ({
  root: {
    minHeight: '100vh'
  }
});

class LayoutInApp extends Component {
  state = {
    showDrawer: false
  };

  onMenuClick = () => {};

  toggleDrawer = () => {
    this.setState({
      showDrawer: !this.state.showDrawer
    });
  };

  onDrawerClose = () => {
    this.setState({
      showDrawer: false
    });
  };

  onDrawerOpen = () => {
    this.setState({
      showDrawer: true
    });
  };

  render() {
    const { classes, children, history, auth } = this.props;
    const { showDrawer } = this.state;
    const { isAuthenticated } = auth;
    let isAdmin;
    let isBuyer;

    if (auth.user) {
      auth.user.roles.find(role => role === 'admin')
        ? (isAdmin = true)
        : (isAdmin = false);
      console.log(isAdmin);
    }

    if (auth.user) {
      auth.user.roles.find(role => role === 'buyer')
        ? (isBuyer = true)
        : (isBuyer = false);
      console.log(isBuyer);
    }

    return (
      <div className={classes.root}>
        <AppBar
          toggleDrawer={this.toggleDrawer}
          history={history}
          isAuthenticated={isAuthenticated}
          isAdmin={isAdmin}
          isBuyer={isBuyer}
        />
        <Drawer
          history={history}
          showDrawer={showDrawer}
          onOpen={this.onDrawerOpen}
          onClose={this.onDrawerClose}
          isAuthenticated={isAuthenticated}
          isAdmin={isAdmin}
          isBuyer={isBuyer}
        />
        {children}
      </div>
    );
  }
}
const mapStateToProps = state => {
  return {
    auth: state.auth
  };
};

const mapDispatchToProps = dispatch => {
  return {
    // createUser: user => dispatch(actions.registerInit(user))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(LayoutInApp));
