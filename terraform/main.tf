terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "fodi" # <-- makes Terraform use ~/.aws/credentials [fodi]
}

# Build the ZIP from your app/ folder
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../app"
  output_path = "${path.module}/lambda.zip"
}

data "archive_file" "lambda_zip2" {
  type        = "zip"
  source_dir  = "${path.module}/../app2"
  output_path = "${path.module}/lambda2.zip"
}

data "archive_file" "lambda_zip3" {
  type        = "zip"
  source_dir  = "${path.module}/../app3"
  output_path = "${path.module}/lambda3.zip"
}
# This is the *execution role* the Lambda runs as (not your user/group)
resource "aws_iam_role" "lambda_role" {
  name = "example_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Allow CloudWatch logs
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "example" {
  function_name = "example_lambda"
  runtime       = "python3.11"
  handler       = "main.lambda_handler"

  role = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout     = 10
  memory_size = 128
}

resource "aws_lambda_function" "example2" {
  function_name = "example2_lambda"
  runtime       = "python3.11"
  handler       = "main.lambda_handler"

  role = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.lambda_zip2.output_path
  source_code_hash = data.archive_file.lambda_zip2.output_base64sha256

  timeout     = 10
  memory_size = 128
}


resource "aws_lambda_function" "example3" {
  function_name = "example3_lambda"
  runtime       = "python3.11"
  handler       = "main.lambda_handler"

  role = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.lambda_zip3.output_path
  source_code_hash = data.archive_file.lambda_zip3.output_base64sha256

  timeout     = 10
  memory_size = 128
}