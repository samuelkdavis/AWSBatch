resource "aws_iam_role" "lambda_trigger_iam_role" {
  name = "${var.NAMESPACE}-lambda-trigger-iam-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "lambda.amazonaws.com"
        }
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  role       = "${aws_iam_role.lambda_trigger_iam_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "submit_batch_jobs" {
  name       = "${var.NAMESPACE}-submit-batch-jobs"
  roles      = ["${aws_iam_role.lambda_trigger_iam_role.name}"]
  policy_arn = "${aws_iam_policy.submit_batch_jobs.arn}"
}

resource "aws_iam_policy" "submit_batch_jobs" {
  name        = "submit-batch"
  path        = "/"
  description = "Submit batch jobs"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "batch:SubmitJob*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
