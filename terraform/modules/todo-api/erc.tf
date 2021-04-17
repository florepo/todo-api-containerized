resource "aws_ecr_repository" "todoapi_ecr_repo" {
  name = "todoapi_ecr_repo"

  tags = merge(local.default_tags,
    {
      Name      = "ECR Repo"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "todoapi_ecr_repo_policy" {
  repository = aws_ecr_repository.todoapi_ecr_repo.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep image deployed with tag latest",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["latest"],
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep last 2 any images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 2
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
