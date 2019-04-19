provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "= 0.11.13"

  backend "s3" {
    bucket = "paidy-terraform-state-non-production"
    key    = "microservices-alb/staging-01"
    region = "ap-northeast-1"
  }
}
