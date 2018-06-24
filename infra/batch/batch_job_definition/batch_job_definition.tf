variable "NAMESPACE" {}

variable "repository_url" {}

variable "vcpus" {
  default = 1
}

variable "memory" {
  default = 1024
}

resource "aws_batch_job_definition" "batch-job-definition" {
  name = "${var.NAMESPACE}-batch-job-definition"
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
  value = "${var.NAMESPACE}-batch-job-definition" #todo turn into variable
}
