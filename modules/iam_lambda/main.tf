data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    sid    = "CloudwatchId"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    effect = "Allow"
    sid    = "S3id"
    actions = [
      "s3:GetObject",
    ]
    resources = ["${var.s3_bucket_arn}/*"]
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.project_name}-policy"
  description = "Policy to allow S3 and Cloudwatch to a specific resource"
  policy      = data.aws_iam_policy_document.this.json
}


resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${var.project_name}-role"
}

resource "aws_iam_policy_attachment" "this" {
  name = "${var.project_name}-role-attachment"
  roles = [
    aws_iam_role.this.name,
  ]
  policy_arn = aws_iam_policy.this.arn
}


