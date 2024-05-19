data "archive_file" "lambda_vanilla" {
  type        = "zip"
  output_path = var.output_path
  source_file = var.source_file
}

resource "aws_lambda_function" "vanilla" {
  function_name    = "s3-data-processor"
  filename         = data.archive_file.lambda_vanilla.output_path
  role             = var.role_arn
  source_code_hash = data.archive_file.lambda_vanilla.output_base64sha256
  runtime          = "python3.11"
  handler          = "main.lambda_handler"
  timeout          = 10
}