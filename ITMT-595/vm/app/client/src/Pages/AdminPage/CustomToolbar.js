import React from 'react';
import IconButton from '@material-ui/core/IconButton';
import Tooltip from '@material-ui/core/Tooltip';
import { Delete as DeleteIcon } from '@material-ui/icons/';
import { withStyles } from '@material-ui/core/styles';

const defaultToolbarStyles = {
  iconButton: {}
};

class CustomToolbar extends React.Component {
  handleClick = () => {
    console.log('clicked on icon!');
  };

  render() {
    const { classes, deleteButtonType, onDeleteData } = this.props;
    console.log(deleteButtonType);

    if (deleteButtonType === 'users') {
      console.log('user me ');
    } else if (deleteButtonType === 'listings') {
      console.log(' liasings me');
    }

    return (
      <React.Fragment>
        <Tooltip title={'Delete All'}>
          <IconButton
            className={classes.iconButton}
            onClick={onDeleteData(deleteButtonType)}
          >
            <DeleteIcon />
          </IconButton>
        </Tooltip>
      </React.Fragment>
    );
  }
}

export default withStyles(defaultToolbarStyles, { name: 'CustomToolbar' })(
  CustomToolbar
);
