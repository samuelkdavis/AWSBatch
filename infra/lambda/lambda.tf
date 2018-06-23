variable "job_queue_name" {}
variable "job_definition" {}

resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_function_name"
  description      = "Triggers AWS Batch when invoked"
  role             = "${aws_iam_role.lambda_trigger_iam_role.arn}"
  handler          = "exports.test"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  runtime          = "python3.6"                                            #"nodejs4.3"
  Timeout          = "60"

  environment {
    variables = {
      jobQueue      = "${var.job_queue_name}"
      jobDefinition = "${var.job_definition}"
    }
  }
}
