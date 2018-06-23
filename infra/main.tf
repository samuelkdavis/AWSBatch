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
  source    = "./batch/batch_job_definition"
  NAMESPACE = "${var.NAMESPACE}"
}
