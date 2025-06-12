
resource "aws_ecr_repository" "webapp_repo" {
  name                 = "java-webapp-repo"
  image_tag_mutability = "MUTABLE"

  lifecycle_policy {
    policy = jsonencode({
      rules = [{
        rulePriority = 1
        description  = "Expire untagged images after 30 days"
        selection = {
          tagStatus     = "untagged"
          countType     = "sinceImagePushed"
          countUnit     = "days"
          countNumber   = 30
        }
        action = {
          type = "expire"
        }
      }]
    })
  }

  tags = {
    Project = "ECS-Demo"
  }
}
