#!/bin/bash

# Run this script: bash ./upload-images-to-s3.sh $(< ~/arguments.txt)

# S3 commands
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html
# Upload illinoistech.png and rohit.jpg to bucket ${19}

if [ $# = 0 ]
then
  echo "You don't have enough variables in your arugments.txt, you need to pass your argument.txt file..."
  echo "Execute: bash ./upload-images-to-s3.sh $(< ~/arguments.txt)"
  exit 1 
else
    echo "Uploading image: ./images/illinoistech.png to s3://${19}..."
    aws s3 cp ./images/illinoistech.png s3://${19}
    echo "Uploaded image: ./images/illinoistech.png to s3://${19}..."

    echo "Uploading image: ./images/rohit.jpg to s3://${19}..."
    aws s3 cp ./images/rohit.jpg s3://${19}
    echo "Uploaded image: ./images/rohit.jpg to s3://${19}..."

    echo "Listing content of bucket: s3://${19}..."
    aws s3 ls s3://${19}

    # Upload ranking.jpg and elevate.webp to bucket ${20}
    echo "Uploading image: ./images/elevate.webp to s3://${20}..."
    aws s3 cp ./images/elevate.webp s3://${20}
    echo "Uploaded image: ./images/elevate.webp to s3://${20}..."

    echo "Uploading image: ./images/ranking.jpg to s3://${20}..."
    aws s3 cp ./images/ranking.jpg s3://${20}
    echo "Uploaded image: ./images/ranking.jpg to s3://${20}..."

    echo "Listing content of bucket: s3://${20}..."
    aws s3 ls s3://${20}
# End of if
fi
