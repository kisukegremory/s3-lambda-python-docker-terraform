resource "aws_ecr_repository" "this" {
    name = var.repo_name
}


data "aws_ecr_image" "this" {
  repository_name = aws_ecr_repository.this.name
  image_tag = "latest"
}