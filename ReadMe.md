h1. Run instructions

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