import React from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import { withStyles } from '@material-ui/core/styles';
import {
  Typography,
  Grid,
  Button,
  List,
  ListItem,
  ListItemText,
  Divider
} from '@material-ui/core';

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
  grid: {
    width: '85%'
  },
  buttonGrid: {
    marginTop: '5vh',
    marginBottom: '10vh',
    width: '100%',
    justifyContent: 'space-between'
  },
  formHeader: {
    display: 'block',
    marginBottom: '5vh',
    width: '85%',
    padding: '2% 2%',
    backgroundColor: '#fff',
    boxShadow: `0px 1px 5px 0px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 3px 1px -2px rgba(0,0,0,0.12)`,
    // fontSize: '25vw',
    borderRadius: '4px',
    boxSizing: 'inherit',
    margin: '0 auto',
    [theme.breakpoints.up('md')]: {
      // fontSize: '15vh'
    }
  },
  list: {
    background: theme.palette.background.paper,
    boxShadow: `0px 1px 5px 0px rgba(0,0,0,0.2),0px 2px 2px 0px rgba(0,0,0,0.14),0px 3px 1px -2px rgba(0,0,0,0.12)`,
    borderRadius: '4px',
    ' & span': {
      fontSize: '1.3rem'
    },
    '& p': {
      fontSize: '22px'
    }
  }
});

const Confirm = props => {
  const { classes } = props;

  const {
    values: { firstName, lastName, email, bio, roles }
  } = props;

  const goBack = e => {
    e.preventDefault();
    props.prevStep();
  };

  const submitUser = e => {
    e.preventDefault();
    props.submitUser();
  };
  return (
    <div className={classes.root}>
      <Typography className={classes.formHeader} variant="h6" color="primary">
        Let's review & confirm the details:
      </Typography>
      <Grid container className={classes.grid}>
        <Grid item xs={12}>
          <List className={classes.list}>
            <ListItem>
              <ListItemText
                primary="First Name:"
                secondary={firstName || 'N/A'}
              />
            </ListItem>
            <Divider />
            <ListItem>
              <ListItemText
                primary="Last Name:"
                secondary={lastName || 'N/A'}
              />
            </ListItem>
            <Divider />
            <ListItem>
              <ListItemText
                primary="Email Address:"
                secondary={email || 'N/A'}
              />
            </ListItem>
            <Divider />
            <ListItem>
              <ListItemText primary="Bio:" secondary={bio || 'N/A'} />
            </ListItem>
            <Divider />
            <ListItem>
              <ListItemText
                primary="Preferred App Style:"
                secondary={roles[0] || 'N/A'}
              />
            </ListItem>
          </List>
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
              onClick={submitUser}
            >
              Done
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
)(withStyles(styles)(Confirm));
