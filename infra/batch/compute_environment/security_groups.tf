resource "aws_security_group" "batch-compute-security-group" {
  name = "${var.NAMESPACE}-aws_batch_compute_environment_security_group"
}

resource "aws_security_group_rule" "allow_all_ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "All"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.batch-compute-security-group.id}"
}

resource "aws_security_group_rule" "allow_all_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "All"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.batch-compute-security-group.id}"
}
