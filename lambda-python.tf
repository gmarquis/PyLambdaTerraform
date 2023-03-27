data "archive_file" "PyListS3Buckets" {
  type        = "zip"
  source_file = "PyListS3Buckets.py"
  output_path = "PyListS3Buckets.zip"
}

data "archive_file" "PyRandomPassword" {
  type        = "zip"
  source_file = "PyRandomPassword.py"
  output_path = "PyRandomPassword.zip"
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_lambda_function" "PyRandomPassword" {
  function_name    = "PyRandomPassword"
  filename         = "${data.archive_file.PyRandomPassword.output_path}"
  source_code_hash = "${data.archive_file.PyRandomPassword.output_base64sha256}"
  role    = "arn:aws:iam::735522019233:role/service-role/PythonHelloWorld-role-3oceq5at"
  handler = "PyRandomPassword.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      greeting = "PyRandomPassword"
    }
  }
}

resource "aws_lambda_function_url" "PyRandomPassword" {
  function_name      = "PyRandomPassword"
  authorization_type = "NONE"
}

resource "aws_lambda_function" "PyListS3Buckets" {
  function_name    = "PyListS3Buckets"
  filename         = "${data.archive_file.PyListS3Buckets.output_path}"
  source_code_hash = "${data.archive_file.PyListS3Buckets.output_base64sha256}"
  role    = "arn:aws:iam::735522019233:role/service-role/PythonHelloWorld-role-3oceq5at"
  handler = "PyListS3Buckets.lambda_handler"
  runtime = "python3.9"

  environment {
    variables = {
      greeting = "PyListS3Buckets"
    }
  }
}

resource "aws_lambda_function_url" "PyListS3Buckets" {
  function_name      = "PyListS3Buckets"
  authorization_type = "NONE"
}
