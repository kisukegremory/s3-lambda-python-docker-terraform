resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  tags          = var.tags
  force_destroy = true
}