variable "NAMESPACE" {}
variable "batch_compute_environment_arn" {}

resource "aws_batch_job_queue" "batch_queue" {
  name                 = "${var.NAMESPACE}-batch-queue"
  state                = "ENABLED"
  priority             = 1
  compute_environments = ["${var.batch_compute_environment_arn}"]
}
