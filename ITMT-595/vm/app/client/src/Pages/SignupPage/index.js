import React, { Component } from 'react';
import { connect } from 'react-redux';
import Image from '../../assets/images/bedroom.jpg';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import { Typography } from '@material-ui/core/';
import Form1 from './Form1';
import Form2 from './Form2';
import Form3 from './Form3';
import Confirm from './Confirm';

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
    marginTop: '5vh',
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

class SignupForm extends Component {
  state = {
    step: 1,
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    phoneNumber: '',
    bio: '',
    roles: [],
    buyerButtonColor: 'default',
    sellerButtonColor: 'default'
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

  submitUser = e => {
    const {
      bio,
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
      roles
    } = this.state;
    const user = {
      bio,
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
      roles
    };
    this.props.createUser(user, this.props.history);
  };

  loginOnClick = () => this.props.history.push('/home');
  backOnClick = () => this.props.history.push('/');
  render() {
    const { classes } = this.props;
    const { step } = this.state;
    const {
      firstName,
      lastName,
      email,
      password,
      bio,
      roles,
      buyerButtonColor,
      sellerButtonColor
    } = this.state;

    const values = {
      firstName,
      lastName,
      email,
      password,
      bio,
      roles,
      buyerButtonColor,
      sellerButtonColor
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
            values={values}
          />
        );
        break;
      case 2:
        renderedPage = (
          <Form2
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handleChange}
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
          <Confirm
            nextStep={this.nextStep}
            prevStep={this.prevStep}
            handleChange={this.handleChange}
            toggleButton={this.toggleButton}
            submitUser={this.submitUser}
            values={values}
          />
        );
        break;
      default:
        return;
    }

    return (
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
    createUser: (user, history) => dispatch(actions.registerInit(user, history))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(SignupForm));
