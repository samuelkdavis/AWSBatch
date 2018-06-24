#!/usr/bin/env python
from __future__ import print_function
import boto3
import os
import random 
import string

'''
This lambda handler submits a job to a AWS Batch queue.
JobQueue, and JobDefinition environment variables must be set. 
These environment variables are intended to be set to the Name, not the Arn. 
S3 event body parsed from the structure defined here https://docs.aws.amazon.com/AmazonS3/latest/dev/notification-content-structure.html
'''
def lambda_handler(event,context):
    # Grab data from environment
    jobqueue = os.environ['JobQueue']
    jobdef = os.environ['JobDefinition']

    f = lambda x: print(x)

    bucket_name = event['Records'][0]['s3']['bucket']['name']
    file_key = event['Records'][0]['s3']['object']['key']
    
    f(bucket_name)
    f(file_key)

    # Create unique name for the job (this does not need to be unique)
    job1Name = 'job1' + ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))

    # Set up a batch client 
    session = boto3.session.Session()
    client = session.client('batch')

    # Submit the job
    job1 = client.submit_job(
        jobName=job1Name,
        jobQueue=jobqueue,
        jobDefinition=jobdef,
        parameters={
            's3BucketName': bucket_name,
            's3FileKey': file_key
        }
    )
    print("Started Job: {}".format(job1['jobName']))
