import React from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import { Typography, Grid, Button } from '@material-ui/core';

const styles = theme => ({
  root: {
    width: '100%',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    height: '100%'
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
    width: '85%'
  },
  buttonGrid: {
    marginTop: '15vh',
    marginBottom: '10vh',
    width: '100%',
    justifyContent: 'space-between'
  },
  textField: {
    width: '100%',
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
    fontSize: '22px !important',
    '& label': {
      color: '#fff',
      fontSize: '22px'
    },
    '& label[data-shrink="true"]': {
      color: '#fff'
    }
  },
  formHeader: {
    display: 'block',
    marginBottom: '5vh',
    width: '85%',
    padding: '2% 2%',
    backgroundColor: '#fff',
    boxShadow: `0px 1px 5px 0px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 3px 1px -2px rgba(0,0,0,0.12)`,
    borderRadius: '4px',
    boxSizing: 'inherit',
    margin: '0 auto'
  }
});

const Form2 = props => {
  const { classes, values, toggleButton } = props;
  const nextPage = e => {
    e.preventDefault();
    props.nextStep();
  };

  const goBack = e => {
    e.preventDefault();
    props.prevStep();
  };

  return (
    <div className={classes.root}>
      <Typography className={classes.formHeader} variant="h6" color="primary">
        Tell us a bit about yourself:
      </Typography>
      <Grid container className={classes.grid}>
        <Grid item xs={12}>
          <Button
            id="buyerButton"
            name="roomie"
            value="buyer"
            variant="contained"
            color={values.buyerButtonColor}
            className={classes.button}
            onClick={toggleButton('buyer')}
          >
            Im looking for a roomie
          </Button>
        </Grid>
        <Grid item xs={12}>
          <Button
            id="sellerButton"
            name="seller"
            value="seller"
            variant="contained"
            color={values.sellerButtonColor}
            className={classes.button}
            onClick={toggleButton('seller')}
          >
            Im looking to sell property
          </Button>
        </Grid>

        {/* Button Grid */}
        <Grid container className={classes.buttonGrid}>
          <Grid item xs={4}>
            <Button
              variant="contained"
              color="secondary"
              className={classes.button}
              onClick={goBack}
            >
              Back
            </Button>
          </Grid>
          <Grid item xs={4}>
            <Button
              variant="contained"
              color="primary"
              className={classes.button}
              onClick={nextPage}
            >
              Continue
            </Button>
          </Grid>
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
)(withStyles(styles)(Form2));
