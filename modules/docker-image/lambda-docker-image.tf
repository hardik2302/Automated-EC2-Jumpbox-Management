resource "null_resource" "build_and_push_image" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${var.lambda_ecr_details.repository_url}
      docker build -t ${var.lambda_ecr_details.repository_url}:ec2-jumpbox-automation ${path.module}/lambda-function-image/.
      docker push ${var.lambda_ecr_details.repository_url}:ec2-jumpbox-automation
    EOT

    environment = {
      AWS_PROFILE = "default"
    }
  }
}