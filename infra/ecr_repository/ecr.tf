variable "NAMESPACE" {}

resource "aws_ecr_repository" "ecr_repository" {
  name = "${var.NAMESPACE}-ecr-repository"
}

output "repository_url" {
  value = "${aws_ecr_repository.ecr_repository.repository_url}"
}
