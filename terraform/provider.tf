terraform {
  required_version = ">= 0.12"

  backend "s3" {
    key     = "infra/aws.tfstate"
    bucket  = "barrucadu-awsfiles-terraform-remote-state"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.0"
}
