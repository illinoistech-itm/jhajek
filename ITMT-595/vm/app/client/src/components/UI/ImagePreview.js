import React from 'react';
import { Typography } from '@material-ui/core';
import { withStyles } from '@material-ui/core/styles';

const styles = theme => ({
  root: {
    maxWidth: '100%',
    height: '100%',
    background: 'black',
    display: 'flex',
    flexWrap: 'wrap'
  },
  image: {
    maxWidth: '25%',
    margin: '5px'
  }
});

const ImagePreview = props => {
  const { values, classes } = props;
  let images;

  if (values.photos) {
    images = values.photos.map((image, index) => {
      return (
        <img
          key={index}
          src={URL.createObjectURL(image)}
          alt={'Upload preview' + index}
          className={classes.image}
        />
      );
    });
  }
  return <div>{images}</div>;
};

export default withStyles(styles)(ImagePreview);
