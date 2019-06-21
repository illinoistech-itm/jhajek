import React from 'react';
import { withStyles } from '@material-ui/core/styles';
import {
  SwipeableDrawer,
  Button,
  List,
  Divider,
  ListItem,
  ListItemIcon,
  ListItemText
} from '@material-ui/core/';
import {
  MoveToInbox as InboxIcon,
  Mail as MailIcon,
  Person as ProfileIcon,
  Home as HomeIcon,
  LibraryAdd as AddListingIcon,
  Settings as SettingsIcon,
  VpnKey as AdminIcon,
  Input as LogoutIcon
} from '@material-ui/icons/';

const styles = {
  list: {
    width: 250
  },
  fullList: {
    width: 'auto'
  }
};

function SwipeableTemporaryDrawer(props) {
  const { classes, onOpen, onClose, history, isAdmin, isBuyer } = props;
  let { showDrawer } = props;

  const goToLink = text => e => {
    switch (text) {
      case 'Home':
        history.push('/home');
        break;
      case 'Create Listing':
        history.push('/createListing');
        break;
      case 'Profile':
        // history.push('/createListing');
        // TODO: Redirect to profile/:id
        break;
      case 'Settings':
        // history.push('/createListing');
        break;
      case 'Admin':
        history.push('/admin');
        break;
      case 'Logout':
        history.push('/logout');
        break;
      default:
        return;
    }
  };
  const createIcon = text => {
    switch (text) {
      case 'Home':
        return <HomeIcon />;
      case 'Create Listing':
        return <AddListingIcon />;
      case 'Profile (Coming soon!)':
        return <ProfileIcon />;
      case 'Settings (Coming soon!)':
        return <SettingsIcon />;
      case 'Admin':
        return <AdminIcon />;
      case 'Logout':
        return <LogoutIcon />;
      default:
        return;
    }
  };
  const fullList = (
    <div className={classes.fullList}>
      <List>
        {['Home', 'Profile (Coming soon!)'].map((text, index) => (
          <ListItem button key={text} onClick={goToLink(text)}>
            <ListItemIcon>{createIcon(text)}</ListItemIcon>
            <ListItemText primary={text} />
          </ListItem>
        ))}
        {!isBuyer && (
          <ListItem
            button
            key={'Create Listing'}
            onClick={goToLink('Create Listing')}
          >
            <ListItemIcon>{createIcon('Create Listing')}</ListItemIcon>
            <ListItemText primary={'Create Listing'} />
          </ListItem>
        )}
      </List>
      <Divider />
      <List>
        {isAdmin && (
          <ListItem button key={'Admin'} onClick={goToLink('Admin')}>
            <ListItemIcon>{createIcon('Admin')}</ListItemIcon>
            <ListItemText primary={'Admin'} />
          </ListItem>
        )}
        {['Settings (Coming soon!)', 'Logout'].map((text, index) => (
          <ListItem button key={text} onClick={goToLink(text)}>
            <ListItemIcon>{createIcon(text)}</ListItemIcon>
            <ListItemText primary={text} />
          </ListItem>
        ))}
      </List>
    </div>
  );

  return (
    <div>
      <SwipeableDrawer
        anchor='bottom'
        open={showDrawer}
        onClose={onClose}
        onOpen={onOpen}
      >
        <div tabIndex={0} role='button' onClick={onClose} onKeyDown={onClose}>
          {fullList}
        </div>
      </SwipeableDrawer>
    </div>
  );
}

export default withStyles(styles)(SwipeableTemporaryDrawer);
