variable "NAMESPACE" {}

variable "repository_url" {}

variable "vcpus" {
  default = 1
}

variable "memory" {
  default = 1024
}

locals {
  batch_job_definition_name = "${var.NAMESPACE}-batch-job-definition"
}

resource "aws_batch_job_definition" "batch-job-definition" {
  name = "${local.batch_job_definition_name}"
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
    "command": [],
    "image": "${var.repository_url}",
    "memory": ${var.memory},
    "vcpus": ${var.vcpus},
    "volumes": [],
    "environment": [
        {"name": "VARNAME", "value": "VARVAL"}
    ],
    "mountPoints": [],
    "ulimits": []
}
CONTAINER_PROPERTIES
}

output "batch_job_definition_name" {
  value = "${local.batch_job_definition_name}"
}
