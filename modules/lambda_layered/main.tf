
data "archive_file" "lambda_layered" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.output_path
}

resource "aws_lambda_function" "layered" {
  function_name    = "data-requester"
  filename         = data.archive_file.lambda_layered.output_path
  role             = var.role_arn
  source_code_hash = data.archive_file.lambda_layered.output_base64sha256
  runtime          = "python3.10"
  handler          = "main.lambda_handler"
  timeout          = 10
  layers           = var.layers
}
