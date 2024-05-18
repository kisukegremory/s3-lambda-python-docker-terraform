locals {
    project_name = "s3-lambda-python-docker-terraform"
}


locals {
  commom_tags = {
    managedBy = "terraform"
    project = local.project_name
  }
}