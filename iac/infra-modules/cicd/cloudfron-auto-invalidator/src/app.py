from __future__ import print_function
import boto3
import json
import urllib
import time
from botocore.config import Config

aws_config = Config(
    region_name = 'us-east-1'
)

cloudfront_client = boto3.client('cloudfront', config=aws_config)


# --------------- Main handler ------------------
def lambda_handler(event, context):
    '''
    Creates a cloudfront invalidation for content added to an S3 bucket
    '''
    # Log the the received event locally.
    print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event.
    cf_distro_id = event['CodePipeline.job']['data']['actionConfiguration']['configuration']['UserParameters']
    print("Creating invalidation on Cloudfront distribution {}".format( cf_distro_id))

    if cf_distro_id:
        print("Creating invalidation on Cloudfront distribution {}".format( cf_distro_id))

        try:
            invalidation = cloudfront_client.create_invalidation(DistributionId=cf_distro_id,
                                                                 InvalidationBatch={
                                                                     'Paths': {
                                                                         'Quantity': 1,
                                                                         'Items': ['/*']
                                                                     },
                                                                     'CallerReference': str(time.time())
                                                                 })

            print("Submitted invalidation. ID {} Status {}".format(
                invalidation['Invalidation']['Id'], invalidation['Invalidation']['Status']))
        except Exception as e:
            print("Error processing. Event {}".format( json.dumps(event, indent=2)))
            raise e
    else:
        print("No Cloudfront distribution id found".format(cf_distro_id))

    return 'Success'
