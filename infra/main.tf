variable "aws_subnet_id" {
  default = "subnet-e174b7b8"
}

variable "NAMESPACE" {
  default = "ai"
}

provider "aws" {
  region = "ap-southeast-2"
}

module "compute_environment" {
  source = "./batch/compute_environment"

  aws_subnet_id = "${var.aws_subnet_id}"
  NAMESPACE     = "${var.NAMESPACE}"
}

module "batch_queue" {
  source                        = "./batch/batch_queue"
  NAMESPACE                     = "${var.NAMESPACE}"
  batch_compute_environment_arn = "${module.compute_environment.aws_batch_compute_environment_arn}"
}

module "batch_job_definition" {
  source         = "./batch/batch_job_definition"
  NAMESPACE      = "${var.NAMESPACE}"
  repository_url = "${module.ecr_repository.repository_url}"
}

module "lambda_trigger" {
  source         = "./lambda"
  NAMESPACE      = "${var.NAMESPACE}"
  job_queue_name = "${module.batch_queue.job_queue_name}"
  job_definition = "${module.batch_job_definition.batch_job_definition_name}"
}

module "s3_bucket" {
  source     = "./s3_bucket"
  NAMESPACE  = "${var.NAMESPACE}"
  lambda_arn = "${module.lambda_trigger.lambda_arn}"
}

module "ecr_repository" {
  source    = "./ecr_repository"
  NAMESPACE = "${var.NAMESPACE}"
}
