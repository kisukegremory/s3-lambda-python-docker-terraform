terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.2"
    }
  }
}

module "s3_input_data" {
  source = "./modules/s3_input_data"
  bucket = "${local.project_name}-input-data"
  tags   = local.commom_tags
}


module "iam_lambda" {
  source        = "./modules/iam_lambda"
  project_name  = local.project_name
  s3_bucket_arn = module.s3_input_data.bucket_arn
}

# module "httpx_layer" {
#   source      = "./modules/httpx_layer"
#   output_path = "${local.artifact_source}/${local.project_name}-httpx-layer.zip"
#   source_dir  = "./httpx-layer"
# }


# module "lambda_layered" {
#   source      = "./modules/lambda_layered"
#   source_file = "${local.code_source}/lambda_layered/main.py"
#   output_path = "${local.artifact_source}/${local.project_name}-layered.zip"
#   layers      = [module.httpx_layer.httpx_layer_arn]
#   role_arn    = module.iam_lambda.role_arn
# }

module "ecr" {
  source    = "./modules/ecr_repo"
  repo_name = "lambda_etl_processor"
}

module "lambda_container" {
  source = "./modules/lambda_container"
  role_arn = module.iam_lambda.role_arn
  image_uri = module.ecr.image_uri
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_container.lambda_arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_input_data.bucket_arn
}

resource "aws_s3_bucket_notification" "this" {
  bucket = module.s3_input_data.bucket_id
  lambda_function {
    lambda_function_arn = module.lambda_container.lambda_arn
    events = [ "s3:ObjectCreated:*" ]
    filter_suffix = ".csv"
  }

  depends_on = [ aws_lambda_permission.allow_bucket ]
}


