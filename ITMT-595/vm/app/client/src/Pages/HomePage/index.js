import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import LayoutInApp from '../../Layout/LayoutInApp';
import ListingView from '../ListingView/ListingView';
import * as actions from '../../store/actions';
import { connect } from 'react-redux';

const styles = theme => ({
  root: {
    minHeight: '100vh',
    /*Photo by Buenosia Carol from Pexels*/
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center'
  }
});

class HomePage extends Component {
  state = {};
  componentDidMount() {
    // this.props.getUsers();
    this.props.getListings();
  }
  render() {
    const array = this.props.listings;
    const { history } = this.props;
    return (
      <LayoutInApp history={history}>
        {array.map((item, index) => (
          <ListingView data={array[index]} />
        ))}
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
    getListings: () => dispatch(actions.getListingsInit())
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(HomePage));
