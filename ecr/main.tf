resource "aws_ecr_repository" "cz-ecr-demo" {
  tags = {
    NAME = "cz-ecr-demo"
  }

  name = "cz-ecr-demo"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}