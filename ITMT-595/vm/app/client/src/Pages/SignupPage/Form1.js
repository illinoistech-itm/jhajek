import React from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import { Typography, Grid, Button, TextField } from '@material-ui/core';

const styles = theme => ({
  root: {
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
    marginBottom: '5vh',
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

  const nextPage = e => {
    e.preventDefault();
    props.nextStep();
  };

  const goBack = e => {
    e.preventDefault();
    props.history.push('/');
  };

  return (
    <div className={classes.root}>
      <Typography className={classes.formHeader} variant='h6' color='primary'>
        Lets start some general account details:
      </Typography>
      <Grid container className={classes.grid}>
        <Grid item xs={12}>
          <TextField
            id='firstName'
            label='First name'
            placeholder='First name'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('firstName')}
            defaultValue={values.firstName}
            InputProps={{
              className: classes.input,
              classes: { underline: classes.underline, input: classes.input }
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='lastName'
            label='Last name'
            placeholder='Last name'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('lastName')}
            defaultValue={values.lastName}
            InputProps={{
              className: classes.input,
              classes: { underline: classes.underline, input: classes.input }
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='email'
            label='Email'
            placeholder='Email address'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('email')}
            defaultValue={values.email}
            InputProps={{
              className: classes.input,
              classes: { underline: classes.underline, input: classes.input },
              type: 'email'
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='password'
            label='Password'
            placeholder='Password'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('password')}
            defaultValue={values.password}
            InputProps={{
              className: classes.input,
              classes: { underline: classes.underline, input: classes.input },
              type: 'password'
            }}
          />
        </Grid>
        <Grid item xs={12}>
          <TextField
            id='phoneNumber'
            label='Phone number'
            placeholder='Phone number'
            className={classes.textField}
            margin='normal'
            variant='filled'
            onChange={handleChange('phoneNumber')}
            defaultValue={values.phoneNumber}
            InputProps={{
              className: classes.input,
              classes: { underline: classes.underline, input: classes.input },
              type: 'tel'
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
