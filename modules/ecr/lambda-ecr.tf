resource "aws_ecr_repository" "ecr_repo" {
  name = "jumpbox-automation"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.ecr_repo.name
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
  EOF
}

output "lambda_ecr_details" {
  value = {
    arn = aws_ecr_repository.ecr_repo.arn
    registry_id = aws_ecr_repository.ecr_repo.registry_id
    repository_url = aws_ecr_repository.ecr_repo.repository_url
  }
}