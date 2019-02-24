provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
  version = "~> 1.25"
}

variable "aws_region"  {}
variable "aws_profile" {}
