import boto3

#https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Object.upload_file
s3 = boto3.resource('s3')
s3.Object('fall2020-jrh', 'rendered-image-3345').upload_file('./thunbnail.png')