data "archive_file" "lambda_vanilla" {
  type        = "zip"
  source_file = "lambda_vanilla/main.py"
  output_path = "${local.project_name}-vanilla.zip"
}

resource "aws_lambda_function" "vanilla" {
  function_name    = "s3-data-processor"
  filename         = data.archive_file.lambda_vanilla.output_path
  role             = aws_iam_role.this.arn
  source_code_hash = data.archive_file.lambda_vanilla.output_base64sha256
  runtime          = "python3.11"
  handler          = "main.lambda_handler"
  timeout          = 10
}
