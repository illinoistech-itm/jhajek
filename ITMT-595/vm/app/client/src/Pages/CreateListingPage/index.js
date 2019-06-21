import React, { Component } from 'react';
import { connect } from 'react-redux';
import Image from '../../assets/images/bedroom.jpg';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import { Typography } from '@material-ui/core/';
import Form1 from './Form1';
import Form2 from './Form2';
import Form3 from './Form3';
import Form4 from './Form4';
import Confirm from './Confirm';
import LayoutInApp from '../../Layout/LayoutInApp';

const styles = theme => ({
  root: {
    minHeight: '100vh',
    width: '100%',
    /*Photo by Buenosia Carol from Pexels*/
    backgroundImage: `linear-gradient(
      rgba(0, 0, 0, .4) 60%, 
      rgba(0, 0, 0, 0.4)
    ), url(${Image})`,
    backgroundPosition: 'center center',
    backgroundRepeat: 'repeat',
    backgroundSize: 'cover',
    backgroundAttachment: 'fixed',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    overflow: 'visible'
  },
  brandName: {
    display: 'block',
    marginTop: '15vh',
    marginBottom: '5vh',
    width: '100%',
    fontSize: '25vw',
    margin: '0 auto',
    textAlign: 'center',
    [theme.breakpoints.up('md')]: {
      fontSize: '15vh'
    }
  }
});

class ListingForm extends Component {
  state = {
    step: 1,
    address: {
      street: '',
      city: '',
      state: '',
      zipCode: ''
    },
    price: 0,
    squareFootage: 0,
    bedrooms: 0,
    bathrooms: 0,
    listingType: '',
    dateAvailable: null,
    amenities: {
      wifi: false,
      heating: false,
      cooling: false,
      washer: false,
      indoorFireplace: false,
      parkingType: [],
      petsAllowed: [],
      name: '',
      photos: [],
      previewImages: []
    }
  };

  // Proceed to next step
  nextStep = () => {
    const { step } = this.state;
    this.setState({
      step: step + 1
    });
  };

  // Go back to prev step
  prevStep = () => {
    const { step } = this.state;
    this.setState({
      step: step - 1
    });
  };

  // Handle fields change
  handleChange = input => e => {
    this.setState({ [input]: e.target.value });
  };

  // Handle address change
  handleAddressChange = input => e => {
    this.setState({
      address: {
        ...this.state.address,
        [input]: e.target.value
      }
    });
  };

  // Handle address change
  handleArrayChanges = input => e => {
    if (e.target.id === 'listingType') {
      this.setState({
        [input]: [e.target.value]
      });
    }
  };

  // Handle photos change
  handlePhotoChange = (input, acceptedFiles) => {
    console.log(input, acceptedFiles);

    this.setState({
      [input]: acceptedFiles
    });
  };

  toggleButton = input => e => {
    if (input === 'buyer') {
      this.setState({
        buyerButtonColor: 'primary',
        sellerButtonColor: 'default',
        roles: ['buyer']
      });
    } else {
      this.setState({
        sellerButtonColor: 'primary',
        buyerButtonColor: 'default',
        roles: ['seller']
      });
    }
  };

  submitListing = e => {
    const {
      address,
      price,
      squareFootage,
      bedrooms,
      bathrooms,
      listingType,
      dateAvailable,
      amenities,
      name,
      photos
    } = this.state;

    const listing = {
      address,
      price,
      squareFootage,
      bedrooms,
      bathrooms,
      listingType,
      dateAvailable,
      amenities,
      name,
      photos
    };

    this.props.addListing(listing, this.props.history);
  };

  submitPhotos = () => {};

  loginOnClick = () => this.props.history.push('/home');
  backOnClick = () => this.props.history.push('/');
  render() {
    const { classes } = this.props;
    const { step } = this.state;
    const {
      address,
      price,
      squareFootage,
      bedrooms,
      bathrooms,
      listingType,
      dateAvailable,
      amenities,
      name,
      photos,
      previewImages
    } = this.state;

    const values = {
      address,
      price,
      squareFootage,
      bedrooms,
      bathrooms,
      listingType,
      dateAvailable,
      amenities,
      name,
      photos,
      previewImages
    };
    let renderedPage;

    switch (step) {
      case 1:
        renderedPage = (
          <Form1
            history={this.props.history}
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handleChange}
            handleArrayChanges={this.handleArrayChanges}
            values={values}
          />
        );
        break;
      case 2:
        renderedPage = (
          <Form2
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handleAddressChange}
            values={values}
          />
        );
        break;
      case 3:
        renderedPage = (
          <Form3
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handleChange}
            toggleButton={this.toggleButton}
            values={values}
          />
        );
        break;
      case 4:
        renderedPage = (
          <Form4
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handlePhotoChange}
            toggleButton={this.toggleButton}
            submitListing={this.submitListing}
            values={values}
          />
        );
        break;
      case 5:
        renderedPage = (
          <Confirm
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handleChange}
            toggleButton={this.toggleButton}
            submitListing={this.submitListing}
            values={values}
          />
        );
        break;
      default:
        return;
    }

    return (
      <LayoutInApp history={this.props.history}>
        <div className={classes.root}>
          <Typography
            className={classes.brandName}
            variant='h1'
            color='primary'
            fontWeight={800}
          >
            Roomie<small>&trade;</small>
          </Typography>
          {renderedPage}
        </div>
      </LayoutInApp>
    );
  }
}
const mapStateToProps = state => {
  return {
    // state: reducerSlice.prop
  };
};

const mapDispatchToProps = dispatch => {
  return {
    addListing: (listing, history) =>
      dispatch(actions.addListingInit(listing, history))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(ListingForm));
