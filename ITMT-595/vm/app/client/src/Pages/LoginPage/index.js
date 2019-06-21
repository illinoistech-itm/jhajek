import React, { Component } from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import Image from '../../assets/images/bedroom.jpg';
import { Typography, Grid, Button, TextField } from '@material-ui/core';

const styles = theme => ({
  root: {
    minHeight: '100vh',
    /*Photo by Buenosia Carol from Pexels*/
    backgroundImage: `linear-gradient(
      rgba(0, 0, 0, .4) 60%, 
      rgba(0, 0, 0, 0.4)
    ), url(${Image})`,
    backgroundPosition: 'center center',
    backgroundRepeat: 'no-repeat',
    backgroundSize: 'cover',
    backgroundAttachment: 'fixed',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center'
  },
  brandName: {
    marginTop: '15vh',
    display: 'block',
    width: '100%',
    fontSize: '25vw',
    margin: '0 auto',
    textAlign: 'center',
    [theme.breakpoints.up('md')]: {
      fontSize: '15vh'
    }
  },
  button: {
    width: '100%',
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit
  },
  input: {
    color: '#fff',
    '&::placeholder': {
      textOverflow: 'ellipsis !important',
      color: '#fff'
    },
    fontSize: '20px'
  },
  underline: {
    '&:before': {
      borderBottom: '1px solid #fff'
    },
    '&:after': {
      borderBottom: `2px solid #fff`
    }
  },
  grid: {
    marginTop: '15vh',
    width: '85%'
  },
  buttonGrid: {
    marginTop: '5vh',
    width: '100%',
    justifyContent: 'space-between'
  },
  textField: {
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
    fontSize: '22px !important',
    '& label': {
      color: '#fff'
    },
    '& label[data-shrink="true"]': {
      color: '#fff'
    }
  }
});

class LoginPage extends Component {
  state = {
    email: '',
    password: ''
  };

  // Handle fields change
  handleChange = e => {
    this.setState({ [e.target.name]: e.target.value });
  };

  loginOnClick = () => this.props.loginInit(this.state, this.props.history);
  backOnClick = () => this.props.history.goBack();

  render() {
    const { classes } = this.props;
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
        <Grid container className={classes.grid}>
          <Grid item xs={12}>
            <TextField
              fullWidth={true}
              id='email'
              label='Email'
              placeholder='Email'
              name='email'
              className={classes.textField}
              margin='normal'
              variant='filled'
              onChange={this.handleChange}
              InputProps={{
                className: classes.input,
                classes: { underline: classes.underline, input: classes.input },
                type: 'email'
              }}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth={true}
              id='password'
              label='Password'
              name='password'
              placeholder='Password'
              className={classes.textField}
              margin='normal'
              variant='filled'
              onChange={this.handleChange}
              InputProps={{
                className: classes.input,
                classes: { underline: classes.underline, input: classes.input },
                type: 'password'
              }}
            />
          </Grid>

          <Grid container className={classes.buttonGrid}>
            <Grid item xs={12}>
              <Button
                variant='contained'
                color='primary'
                className={classes.button}
                onClick={this.loginOnClick}
              >
                Login
              </Button>
            </Grid>
            <Grid item xs={12}>
              <Button
                variant='contained'
                color='secondary'
                className={classes.button}
                onClick={this.backOnClick}
              >
                Back
              </Button>
            </Grid>
          </Grid>
        </Grid>
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
    loginInit: (user, history) => dispatch(actions.loginInit(user, history))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(LoginPage));
