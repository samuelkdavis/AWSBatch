variable "NAMESPACE" {}
variable "job_queue_name" {}
variable "job_definition" {}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../../lambda/batch_job_trigger.py"
  output_path = "${path.module}/batch_job_trigger.zip"
}

resource "aws_lambda_function" "batch_job_trigger" {
  filename         = "${path.module}/batch_job_trigger.zip"
  function_name    = "batch_job_trigger_lambda_handler"
  description      = "Triggers AWS Batch when invoked"
  role             = "${aws_iam_role.lambda_trigger_iam_role.arn}"
  handler          = "batch_job_trigger.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.6"                                           #"nodejs4.3"

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
