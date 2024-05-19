data "archive_file" "lambda_layer" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path
}

resource "aws_lambda_layer_version" "this" {
  layer_name = "httpx-layer"
  filename   = data.archive_file.lambda_layer.output_path

  compatible_runtimes      = ["python3.10"]
  compatible_architectures = ["x86_64"]
}