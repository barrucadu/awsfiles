provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
  version = "~> 1.25"
}

variable "aws_region"  {}
variable "aws_profile" {}

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
