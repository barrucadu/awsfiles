provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
  version    = "~> 1.25"
}

variable "access_key"  {}
variable "secret_key"  {}
variable "region" {
  default = "eu-west-2"
}

/* ************************************************************************* */

variable "group_admin_user_names" {
  type = "list"
}

module "group_admin" {
  source                  = "./modules/group_user"
  group_name              = "admin"
  group_user_names        = ["${var.group_admin_user_names}"]
  group_policy_arns       = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  group_policy_arns_count = 1
}
