output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}