import React from 'react';
import {
  AppBar,
  Toolbar,
  IconButton,
  Typography,
  Menu,
  MenuItem
} from '@material-ui/core/';

import { withStyles } from '@material-ui/core/styles';
import { Menu as MenuIcon, AccountCircle } from '@material-ui/icons';

const styles = theme => ({
  root: {
    flexGrow: 1
  },
  grow: {
    flexGrow: 1
  },
  menuButton: {
    marginLeft: -12,
    marginRight: 20
  }
});

class MenuAppBar extends React.Component {
  state = {
    auth: true,
    anchorEl: null
  };
  handleChange = event => {
    this.setState({ auth: event.target.checked });
  };

  handleMenu = event => {
    this.setState({ anchorEl: event.currentTarget });
  };

  handleClose = item => {
    this.setState({ anchorEl: null });

    switch (item) {
      case 'Home':
        this.props.history.push('/home');
        break;
      case 'Create Listing':
        this.props.history.push('/createListing');
        break;
      case 'Profile':
        // this.props.history.push('/createListing');
        // TODO: Redirect to profile/:id
        break;
      case 'Settings':
        // this.props.history.push('/createListing');
        break;
      case 'Admin':
        this.props.history.push('/admin');
        break;
      case 'Logout':
        this.props.history.push('/logout');
        break;
      default:
        return;
    }
  };

  render() {
    const { classes, toggleDrawer } = this.props;
    let { anchorEl } = this.state;
    const open = Boolean(anchorEl);

    return (
      <div className={classes.root}>
        <AppBar position='static'>
          <Toolbar>
            <IconButton
              className={classes.menuButton}
              color='inherit'
              aria-label='Menu'
              onClick={toggleDrawer}
            >
              <MenuIcon />
            </IconButton>
            <Typography variant='h6' color='inherit' className={classes.grow}>
              Roomie<small>&trade;</small>
            </Typography>

            <div>
              <IconButton
                aria-owns={open ? 'menu-appbar' : undefined}
                aria-haspopup='true'
                onClick={this.handleMenu}
                color='inherit'
              >
                <AccountCircle />
              </IconButton>
              <Menu
                id='menu-appbar'
                anchorEl={anchorEl}
                anchorOrigin={{
                  vertical: 'top',
                  horizontal: 'right'
                }}
                transformOrigin={{
                  vertical: 'top',
                  horizontal: 'right'
                }}
                open={open}
                onClose={this.handleClose}
              >
                <MenuItem onClick={() => this.handleClose('Profile')}>
                  Profile
                </MenuItem>
                <MenuItem onClick={() => this.handleClose('My account')}>
                  My account
                </MenuItem>
                <MenuItem onClick={() => this.handleClose('Logout')}>
                  Logout
                </MenuItem>
              </Menu>
            </div>
          </Toolbar>
        </AppBar>
      </div>
    );
  }
}

MenuAppBar.propTypes = {
  // classes: PropTypes.object.isRequired
};

export default withStyles(styles)(MenuAppBar);
