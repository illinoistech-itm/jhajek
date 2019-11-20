import boto3

# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html
# Get the service resource.
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('RecordsXYZ')
# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html#updating-item
table.update_item(
    Key={
        'Receipt': '5dd4d65c2099f',
        'Email': 'hajek@iit.edu'
    },
    UpdateExpression='SET age = :val1',
    ExpressionAttributeValues={
        ':val1': 26
    }
)