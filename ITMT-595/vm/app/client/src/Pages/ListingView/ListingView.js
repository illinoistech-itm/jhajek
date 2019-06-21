import React, { Component } from 'react';
import LayoutInApp from '../../Layout/LayoutInApp';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import classnames from 'classnames';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Collapse from '@material-ui/core/Collapse';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import Grid from '@material-ui/core/Grid';
import GridList from '@material-ui/core/GridList';
import GridListTile from '@material-ui/core/GridListTile';
import GridListTileBar from '@material-ui/core/GridListTileBar';

import {
  withStyles,
  createMuiTheme,
  MuiThemeProvider
} from '@material-ui/core/styles';
import { FormatAlignLeft, Autorenew } from '@material-ui/icons';

const styles = theme => ({
  card: {
    //maxWidth: 600,
    alignItems: 'center'
  },
  root: {
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'space-around',
    overflow: 'hidden',
    backgroundColor: theme.palette.background.paper
  },
  gridList: {
    flexWrap: 'nowrap',
    // Promote the list into his own layer on Chrome. This cost memory but helps keeping high FPS.
    transform: 'translateZ(0)'
  },
  title: {
    color: theme.palette.primary.light
  },
  titleBar: {
    background:
      'linear-gradient(to top, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 70%, rgba(0,0,0,0) 100%)'
  },
  center: {
    textAlign: 'center'
  }
});

class ListingView extends Component {
  state = { expanded: false };

  handleExpandClick = () => {
    this.setState(state => ({ expanded: !state.expanded }));
  };

  componentDidMount() {
    // this.props.getUsers();
    this.props.getListings();
  }

  render() {
    const { classes, data } = this.props;
    console.log(data.photos);
    function genereateAmenties(data) {
      let amenatiesInfo = '';
      if (data.amenities.cooling) {
        amenatiesInfo = 'This aparment has in-unit cooling. ';
      }
    }

    return (
      <Card className={classes.card}>
        <CardHeader
          className={classes.center}
          title={data.name}
          subheader={data.dateAvailable.substring(0, 10)}
        />
        <CardContent>
          <div className={classes.root}>
            <GridList className={classes.gridList} cols={2.5}>
              {data.photos.map(photo => (
                <GridListTile key={photo.url}>
                  <img src={photo.url} alt={photo.originalName} />
                  <GridListTileBar
                    classes={{
                      root: classes.titleBar,
                      title: classes.title
                    }}
                  />
                </GridListTile>
              ))}
            </GridList>
          </div>
          <Grid container spacing={24} className={classes.center}>
            <Grid item xs={6}>
              <Typography color='primary' variant='h6' component='p'>
                {data.address.street}
              </Typography>
              <Typography color='primary' variant='h6' component='p'>
                {data.address.city} {data.address.state}, {data.address.zipCode}
              </Typography>
            </Grid>
            <Grid item xs={6}>
              <Typography color='primary' variant='h6' component='p'>
                ${data.price.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')}
              </Typography>
              <Typography color='primary' variant='h6' component='p'>
                {data.squareFootage} Sqft.
              </Typography>
            </Grid>
          </Grid>
        </CardContent>
        <CardActions className={classes.actions} disableActionSpacing>
          <IconButton
            className={classnames(classes.expand, {
              [classes.expandOpen]: this.state.expanded
            })}
            onClick={this.handleExpandClick}
            aria-expanded={this.state.expanded}
            aria-label='Show more'
          >
            <ExpandMoreIcon />
          </IconButton>
        </CardActions>
        <Collapse
          in={this.state.expanded}
          className={classes.center}
          timeout='auto'
          unmountOnExit
        >
          <CardContent>
            <Typography color='primary' variant='h6' component='p'>
              Bathrooms: {data.bathrooms}
            </Typography>
            <Typography color='primary' variant='h6' component='p'>
              Bedrooms: {data.bedrooms}
            </Typography>
            <Typography color='primary' variant='h6' component='p'>
              Property Type: {data.listingType}
            </Typography>
          </CardContent>
        </Collapse>
      </Card>
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
)(withStyles(styles)(ListingView));
