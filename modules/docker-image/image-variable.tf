variable "lambda_ecr_details" {
  type = object({
    arn = string
    registry_id = string
    repository_url = string
  })
}