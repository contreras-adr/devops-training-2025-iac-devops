
resource "aws_ecr_repository" "webapp_repo" {
  name                 = "java-webapp-repo"
  image_tag_mutability = "MUTABLE"


  tags = {
    "Project"     = "aws-terraform-iac"
    "Owner"       = "devops-training-2025"
    "Environment" = "dev"
    "CostCenter"  = "training-2025"
  }
}

resource "aws_ecr_lifecycle_policy" "webapp_policy" {
  repository = aws_ecr_repository.webapp_repo.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire untagged images after 30 days",
        selection = {
          tagStatus     = "untagged",
          countType     = "sinceImagePushed",
          countUnit     = "days",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
