import boto3

# link to boto resources: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html

client_ec2 = boto3.client('ec2')

response = client_ec2.describe_instances()

print(response)

print(len(response["Reservations"][0]["Instances"]))