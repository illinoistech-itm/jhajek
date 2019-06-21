import React from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import { unstable_useMediaQuery as useMediaQuery } from '@material-ui/core/useMediaQuery';
import { Typography, Grid, Button, TextField } from '@material-ui/core';

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
    width: '100%',
    justifyContent: 'space-between',
    marginBottom: '10vh',
    marginTop: '5vh'
  },
  textField: {
    width: '100%',
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
    fontSize: '22px !important',
    '& label': {
      color: '#fff'
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

const LoginPage = props => {
  const { classes, values, handleChange } = props;
  const matches = useMediaQuery('(min-width:600px)');

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
      <Typography className={classes.formHeader} variant='h6' color='primary'>
        Tell us more about the property:
      </Typography>
      <Grid container className={classes.grid}>
        <Grid item xs={12}>
          <TextField
            id='bedrooms'
            label='Bedrooms'
            placeholder='Ex. 5'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('bedrooms')}
            defaultValue={values.bedrooms}
            type='number'
            InputProps={{
              className: classes.input,
              classes: {
                underline: classes.underline,
                input: classes.input
              }
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='bathrooms'
            label='Bathrooms'
            placeholder='Ex. 7'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('bathrooms')}
            defaultValue={values.bathrooms}
            type='number'
            InputProps={{
              className: classes.input,
              classes: {
                underline: classes.underline,
                input: classes.input
              }
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='squareFootage'
            label='Square footage'
            placeholder='Ex. 7000'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('squareFootage')}
            defaultValue={values.squareFootage}
            type='number'
            InputProps={{
              className: classes.input,
              classes: {
                underline: classes.underline,
                input: classes.input
              }
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='price'
            label='Price'
            placeholder={matches ? 'Ex. 4700' : ''}
            className={classes.textField}
            margin='normal'
            variant='filled'
            type='number'
            onChange={handleChange('price')}
            defaultValue={values.price}
            InputProps={{
              className: classes.input,
              classes: {
                underline: classes.underline,
                input: classes.input
              }
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='dateAvailable'
            // label={'Date Available'}
            className={classes.textField}
            margin='normal'
            variant='filled'
            type='date'
            onChange={handleChange('dateAvailable')}
            defaultValue={values.dateAvailable}
            InputProps={{
              className: classes.input,
              classes: { underline: classes.underline, input: classes.input }
            }}
          />
        </Grid>

        {/* Button Grid */}
        <Grid container className={classes.buttonGrid}>
          <Grid item xs={4}>
            <Button
              variant='contained'
              color='secondary'
              className={classes.button}
              onClick={goBack}
            >
              Back
            </Button>
          </Grid>
          <Grid item xs={4}>
            <Button
              variant='contained'
              color='primary'
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
)(withStyles(styles)(LoginPage));
