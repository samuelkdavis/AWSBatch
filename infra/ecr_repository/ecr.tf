variable "NAMESPACE" {}

resource "aws_ecr_repository" "ecr_repository" {
  name = "${var.NAMESPACE}-ecr-repository"
}
