import boto3

# link to boto resources: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html

client_ec2 = boto3.client('ec2')

requiredNumberOfInstances = 3
grandTotal = 0
response = client_ec2.describe_instances()

print(response)

NumberOfInstances=len(response["Reservations"][0]["Instances"])

if NumberOfInstances == requiredNumberOfInstances:
    print("Correct!")
    grandTotal += 1
else:
    print("not correct...")