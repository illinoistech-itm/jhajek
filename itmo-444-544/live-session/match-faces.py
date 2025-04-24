import boto3

client = boto3.client('rekognition')

response = client.compare_faces(
    SourceImage={
        'S3Object': {
            'Bucket': 'live-session',
            'Name': 'P12.jpg'
        }
    },
    TargetImage={
        'S3Object': {
            'Bucket': 'live-session',
            'Name': 'P7.jpg'
        }
    }
)

print(response)
