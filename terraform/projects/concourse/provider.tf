terraform {
  backend "s3" {
    key     = "infra/concourse.tfstate"
    bucket  = "barrucadu-awsfiles-terraform-remote-state"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  region  = "eu-west-2"
  version = "~> 2.0"
}
