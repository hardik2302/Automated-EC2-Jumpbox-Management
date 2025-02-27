module "lambda_ecr" {
  source = "./modules/ecr"
  common_vars = {  
    region = var.region
  }
}

module "docker-image" {
  source = "./modules/docker-image"
  lambda_ecr_details = module.lambda_ecr.lambda_ecr_details
  depends_on = [
    module.lambda_ecr
  ]
}

module "lambda_function" {
  source = "./modules/lambda-function"
  lambda_ecr_details = module.lambda_ecr.lambda_ecr_details
  depends_on = [
    module.docker-image
  ]
}