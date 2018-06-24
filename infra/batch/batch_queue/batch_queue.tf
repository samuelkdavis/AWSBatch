variable "NAMESPACE" {}
variable "batch_compute_environment_arn" {}

locals {
  batch_queue_name = "${var.NAMESPACE}-batch-queue"
}

resource "aws_batch_job_queue" "batch_queue" {
  name                 = "${local.batch_queue_name}"
  state                = "ENABLED"
  priority             = 1
  compute_environments = ["${var.batch_compute_environment_arn}"]
}

output "job_queue_name" {
  value = "${local.batch_queue_name}"
}
