import boto3

client = boto3.client('rekognition')

response = client.detect_text(
    Image={
        'S3Object': {
            'Bucket': 'live-session',
            'Name': 'family.png'
        }
    }
)

print(response)
