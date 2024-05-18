

resource "aws_s3_bucket" "this" {
  bucket = "${local.project_name}-input-data"
  tags   = local.commom_tags
}