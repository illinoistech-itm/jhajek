import boto3

clientEC2 = boto3.client('ec2')
grandtotal = 0
totalPoints = 5

response = clientEC2.describe_regions()

# Function to print out current points progress
def currentPoints():
  print("Current Points: " + str(grandtotal) + " out of " + str(totalPoints) + ".")

print(response)

print("The number of regions are: " + str(len(response['Regions'])))

if len(response['Regions']) > 5:
    print("Correct answer you have:" + str(len(response['Regions'])) + " regions...")
    grandtotal += 1
    currentPoints()
else:
    print("You have  an incorrect number of regions: " + str(len(response['Regions'])) + "perhaps check your code where you declared number of regions...")
    currentPoints()

