variable "NAMESPACE" {}
variable "lambda_arn" {}

resource "aws_s3_bucket" "trigger_bucket" {
  bucket = "${var.NAMESPACE}-trigger-bucket"
  acl    = "private"

  tags {
    Name = "${var.NAMESPACE}-trigger-bucket"
  }
}

resource "aws_s3_bucket_notification" "trigger_bucket_notification" {
  bucket = "${aws_s3_bucket.trigger_bucket.id}"

  lambda_function {
    lambda_function_arn = "${var.lambda_arn}"
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.trigger_bucket.arn}"
}
