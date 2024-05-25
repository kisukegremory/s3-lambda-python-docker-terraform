variable "role_arn" {
  type = string
}

variable "image_uri" {
  type = string
}

resource "aws_lambda_function" "containered" {
  function_name = "s3-csv-to-parquet"
  role          = var.role_arn
  image_uri     = var.image_uri
  package_type = "Image"
  timeout       = 30
}

output "lambda_arn" {
  value = aws_lambda_function.containered.arn
}