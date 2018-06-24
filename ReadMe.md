Notes
Batch limits: https://docs.aws.amazon.com/batch/latest/userguide/service_limits.html
Job Timeouts: https://docs.aws.amazon.com/batch/latest/userguide/job_timeouts.html
Max batch jobs: https://www.reddit.com/r/aws/comments/7s7xw6/aws_batch_maximum_jobs/
Submit Job documentation: https://boto3.readthedocs.io/en/latest/reference/services/batch.html#Batch.Client.submit_job
S3 trigger event object structure: https://docs.aws.amazon.com/AmazonS3/latest/dev/notification-content-structure.html
Slides on AWS Batch: https://www.slideshare.net/AmazonWebServices/intro-to-batch-processing-on-aws
Get file name from s3 bucket: https://stackoverflow.com/questions/45851850/how-to-get-latest-file-name-or-file-from-s3-bucket-using-event-triggered-lambda
aws batch example with cloudformation, fanning out: https://github.com/dejonghe/aws-batch-example
aws batch lab, monte carlo, spot instances: https://github.com/aws-samples/ec2-spot-montecarlo-workshop

Performance considerations:
job definition container memory/vcpus
compute environment min/default/max vcpus, memory
compute environment instance type
container spin up time (and how that scales)

Security considerations:
Security Groups allow all traffic to container instances, or services
ecs instance role has full s3 access

Run instructions:

Run from cmd

Run terraform

```
cd infra
terraform init
terraform get
terraform plan
terraform apply
```

Docker commands

```
aws ecr get-login --no-include-email --region ap-southeast-2

docker build -t ai-ecr-repository .
docker tag ai-ecr-repository:latest 956470542728.dkr.ecr.ap-southeast-2.amazonaws.com/ai-ecr-repository:latest
docker push 956470542728.dkr.ecr.ap-southeast-2.amazonaws.com/ai-ecr-repository:latest
```

To run locally from CMD the following commands set the lambda env variables

SET s3FileKey=test.txt
SET s3BucketName=ai-trigger-bucket