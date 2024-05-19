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

data "archive_file" "lambda_layer" {
  type        = "zip"
  source_dir  = "./httpx-layer"
  output_path = "${local.project_name}-httpx-layer2.zip"
}

resource "aws_lambda_layer_version" "this" {
  layer_name = "httpx-layer"
  filename   = data.archive_file.lambda_layer.output_path

  compatible_runtimes      = ["python3.10"]
  compatible_architectures = ["x86_64"]
}



data "archive_file" "lambda_layered" {
  type        = "zip"
  source_file = "lambda_layered/main.py"
  output_path = "${local.project_name}-layered.zip"
}

resource "aws_lambda_function" "layered" {
  function_name    = "data-requester"
  filename         = data.archive_file.lambda_layered.output_path
  role             = aws_iam_role.this.arn
  source_code_hash = data.archive_file.lambda_layered.output_base64sha256
  runtime          = "python3.10"
  handler          = "main.lambda_handler"
  timeout          = 10
  layers           = [aws_lambda_layer_version.this.arn]
}

