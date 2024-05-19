locals {
  project_name = "s3-lambda-python-docker-terraform"
  commom_tags = {
    managedBy = "terraform"
    project   = local.project_name
  }
  function_name   = "lambda_handler"
  artifact_source = "./artifacts"
  code_source     = "./src"
}