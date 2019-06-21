import React from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import Image from '../../assets/images/bedroom.jpg';
import { Typography, Grid, Button } from '@material-ui/core';

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
    fontWeight: '',
    [theme.breakpoints.up('md')]: {
      fontSize: '15vh'
    }
  },
  button: {
    width: '100%',
    marginTop: theme.spacing.unit,
    marginBottom: theme.spacing.unit
  },
  grid: {
    marginTop: '45vh',
    width: '85%'
  }
});

const IndexPage = props => {
  const { classes } = props;
  const loginOnClick = () => props.history.push('/login');
  const signupOnClick = () => props.history.push('/signup');

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
          <Button
            variant='contained'
            color='primary'
            className={classes.button}
            onClick={loginOnClick}
          >
            Login
          </Button>
        </Grid>
        <Grid item xs={12}>
          <Button
            variant='contained'
            color='secondary'
            className={classes.button}
            onClick={signupOnClick}
          >
            Sign Up
          </Button>
        </Grid>
      </Grid>
    </div>
  );
};

const mapStateToProps = state => {
  return {
    // state: reducerSlice.prop
  };
};

const mapDispatchToProps = dispatch => {
  return {
    createUser: user => dispatch(actions.registerInit(user))
  };
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withStyles(styles)(IndexPage));
