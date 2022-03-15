from __future__ import print_function
import boto3
import json
import urllib
import time
from botocore.config import Config

aws_config_cf = Config(
    region_name = 'us-east-1'
)
aws_config_pipeline = Config(
    region_name = 'eu-west-3'
)
cloudfront_client = boto3.client('cloudfront', config=aws_config_cf)
code_pipeline = boto3.client('codepipeline', config=aws_config_pipeline)

def put_job_failure(job):
    """Notify CodePipeline of a failed job
    
    Args:
        job: The CodePipeline job ID
        message: A message to be logged relating to the job status
        
    Raises:
        Exception: Any exception thrown by .put_job_failure_result()
    
    """
    print('Putting job failure {}'.format(job))
    code_pipeline.put_job_failure_result(jobId=job, failureDetails={'message': "Job failed! ", 'type': 'JobFailed'})
 


def put_job_success(job):
    """Notify CodePipeline of a successful job
    
    Args:
        job: The CodePipeline job ID
        message: A message to be logged relating to the job status
        
    Raises:
        Exception: Any exception thrown by .put_job_success_result()
    
    """
    print('Putting job success {}'.format(job))
    code_pipeline.put_job_success_result(jobId=job)

# --------------- Main handler ------------------
def lambda_handler(event, context):
    '''
    Creates a cloudfront invalidation for content added to an S3 bucket
    '''
    # Log the the received event locally.
    print("Received event: " + json.dumps(event, indent=2))
    # Extract the Job ID
    job_id = event['CodePipeline.job']['id']

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
            put_job_success(job_id)
        except Exception as e:
            print("Error processing. Event {}".format( json.dumps(event, indent=2)))
            put_job_failure(job_id)
            raise e
    else:
        print("No Cloudfront distribution id found".format(cf_distro_id))
        put_job_failure(job_id)
    return 'Success'
