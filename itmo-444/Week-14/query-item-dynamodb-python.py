import boto3

# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html
# Get the service resource.
dynamodb = boto3.resource('dynamodb')

# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html#getting-an-item

response = RecordsXYZ.get_item(
    Key={
        'Receipt': '5dd4d65c2099f',
        'Email': 'hajek@iit.edu'
    }
)
item = response['Item']
print(item)

