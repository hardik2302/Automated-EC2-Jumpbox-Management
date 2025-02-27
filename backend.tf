terraform {
  backend "s3" {
    bucket = "backendterraform-state"
    key    = "ec2-jumpbox-automation"
    region = "ap-south-1"
  }
}