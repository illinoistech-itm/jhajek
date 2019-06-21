import React, { Component } from 'react';
import LayoutInApp from '../../Layout/LayoutInApp';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import UsersDataTable from './UsersDataTable';
import ListingsDataTable from './ListingsDataTable';
import {
  withStyles,
  createMuiTheme,
  MuiThemeProvider
} from '@material-ui/core/styles';

import { Button } from '@material-ui/core';

const styles = theme => ({
  root: {
    minHeight: '100vh',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center'
  },
  button: {
    margin: '10px'
  }
});

class ReactAdmin extends Component {
  state = {
    showUsers: true,
    showListings: false
  };

  getMuiTheme = () =>
    createMuiTheme({
      overrides: {
        MUIDataTable: {
          root: {
            backgroundColor: '#FF000',
            overflowX: 'scroll',
            position: 'static',
            width: '100vh'
          },
          paper: {
            boxShadow: 'none'
          }
        }
      }
    });

  componentDidMount() {
    this.props.getUsers();
    this.props.getListings();
  }

  onToggleData = dataSet => e => {
    if (dataSet === 'users') {
      this.setState({
        showUsers: true,
        showListings: false
      });
    } else {
      this.setState({
        showUsers: false,
        showListings: true
      });
    }
  };

  transformUsersData = users => {
    return users.map(user => {
      return [user._id, user.email];
    });
  };

  rowsDeleted = rowsDeleted => {
    console.log(rowsDeleted);
  };

  onDeleteData = dataSet => e => {
    if (dataSet === 'users') {
      this.props.deleteUsers();
    } else if (dataSet === 'listings') {
      this.props.deleteListings();
    }
  };

  render() {
    let { history, users, listings, classes } = this.props;
    let { showUsers, showListings } = this.state;
    let data;
    let toggleButton;
    let deleteButtonType;
    let renderedComponent;

    if (showUsers) {
      data = users;
      deleteButtonType = 'users';
      renderedComponent = (
        <UsersDataTable
          data={data}
          deleteButtonType={deleteButtonType}
          showUsers={this.state.showUsers}
          onDeleteData={this.onDeleteData}
        />
      );
      toggleButton = (
        <Button
          variant='contained'
          color='secondary'
          className={classes.button}
          onClick={this.onToggleData('listings')}
        >
          Switch to Listings
        </Button>
      );
    } else {
      data = listings;
      deleteButtonType = 'listings';
      renderedComponent = (
        <ListingsDataTable
          data={data}
          deleteButtonType={deleteButtonType}
          showListings={this.state.showListings}
          onDeleteData={this.onDeleteData}
        />
      );
      toggleButton = (
        <Button
          variant='contained'
          color='secondary'
          className={classes.button}
          onClick={this.onToggleData('users')}
        >
          Switch to Users
        </Button>
      );
    }
    console.log(showUsers);

    return (
      <LayoutInApp history={history}>
        {toggleButton}
        <MuiThemeProvider theme={this.getMuiTheme()}>
          {renderedComponent}
        </MuiThemeProvider>
      </LayoutInApp>
    );
  }
}

const mapStateToProps = state => {
  return {
    listings: state.listings.listings,
    users: state.users.users
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getUsers: () => dispatch(actions.getUsersInit()),
    getListings: () => dispatch(actions.getListingsInit()),
    deleteListings: () => dispatch(actions.deleteListingsInit()),
    deleteUsers: () => dispatch(actions.deleteUsersInit())
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(ReactAdmin));
