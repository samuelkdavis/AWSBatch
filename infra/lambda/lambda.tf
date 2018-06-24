variable "NAMESPACE" {}
variable "job_queue_name" {}
variable "job_definition" {}

resource "aws_lambda_function" "batch_job_trigger" {
  filename         = "batch_job_trigger.zip"
  function_name    = "batch_job_trigger_lambda_handler"
  description      = "Triggers AWS Batch when invoked"
  role             = "${aws_iam_role.lambda_trigger_iam_role.arn}"
  handler          = "batch_job_trigger.lambda_handler"
  source_code_hash = "${base64sha256(file("batch_job_trigger.zip"))}"
  runtime          = "python3.6"                                      #"nodejs4.3"

  environment {
    variables = {
      JobQueue      = "${var.job_queue_name}"
      JobDefinition = "${var.job_definition}"
    }
  }
}

output "lambda_arn" {
  value = "${aws_lambda_function.batch_job_trigger.arn}"
}
