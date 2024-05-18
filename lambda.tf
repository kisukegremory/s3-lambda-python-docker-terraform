data "archive_file" "lambda" {
  type        = "zip"
  source_file = "src/main.py"
  output_path = "${local.project_name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = "s3-data-processor"
  filename         = data.archive_file.lambda.output_path
  role             = aws_iam_role.this.arn
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.11"
  handler          = "main.lambda_handler"
  timeout          = 10
}
