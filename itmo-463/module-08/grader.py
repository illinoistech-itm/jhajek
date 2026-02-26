import boto3

# link to boto resources: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html

AMOUNT_OF_INSTANCES = 3

client_ec2 = boto3.client('ec2')

grandTotal = 0
response = client_ec2.describe_instances()

print(response)

NumberOfInstances=len(response["Reservations"][1]["Instances"])
print(NumberOfInstances)

if NumberOfInstances == AMOUNT_OF_INSTANCES:
    print("Correct!")
    grandTotal += 1
else:
    print("not correct...")

###############################################################################
# Test 1 check for 3 instances attached to load-balancer
# https://docs.aws.amazon.com/boto3/latest/reference/services/autoscaling.html
# https://docs.aws.amazon.com/boto3/latest/reference/services/autoscaling/client/describe_auto_scaling_instances.html
###############################################################################

client_asg = boto3.client('autoscaling')

response_asg = client_asg.describe_auto_scaling_instances()



if (len(response_asg["AutoScalingInstances"]) == AMOUNT_OF_INSTANCES):
    print("Correct!")
    grandTotal += 1
else:
    print("not correct...")

