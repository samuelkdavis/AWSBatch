variable "NAMESPACE" {}
variable "aws_subnet_id" {}

variable instance_type {
  default = "c4.large"
}

variable "max_vcpus" {
  default = 16
}

variable "min_vcpus" {
  default = 1
}

variable "desired_vcpus" {
  default = 2
}

resource "aws_batch_compute_environment" "batch-compute" {
  compute_environment_name = "${var.NAMESPACE}-batch-compute"

  compute_resources {
    instance_role = "${aws_iam_instance_profile.ecs_instance_role.arn}"

    instance_type = [
      "${var.instance_type}",
    ]

    max_vcpus     = "${var.max_vcpus}"
    min_vcpus     = "${var.min_vcpus}"
    desired_vcpus = "${var.desired_vcpus}"

    security_group_ids = [
      "${aws_security_group.batch-compute-security-group.id}",
    ]

    subnets = [
      "${var.aws_subnet_id}",
    ]

    type = "EC2"
  }

  service_role = "${aws_iam_role.aws_batch_service_role.arn}"
  type         = "MANAGED"
  depends_on   = ["aws_iam_role_policy_attachment.aws_batch_service_role"]
}

output "aws_batch_compute_environment_arn" {
  value = "${aws_batch_compute_environment.batch-compute.arn}"
}
