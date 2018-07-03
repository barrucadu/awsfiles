provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
  version    = "~> 1.25"
}

resource "aws_glacier_vault" "backup" {
  name = "backup"
}

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-2"
}
