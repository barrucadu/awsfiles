variable "group_name" {
  type        = string
  description = "The name of the group"
}

variable "group_user_names" {
  type        = list(string)
  description = "List of names of users that belong to the group"
}

variable "group_policy_arns" {
  type        = list(string)
  description = "List of ARNs of policies to attach to the group"
  default     = []
}

/* ************************************************************************* */

locals {
  create_group = length(var.group_user_names) > 0 ? 1 : 0
}

resource "aws_iam_group" "user_group" {
  count = local.create_group
  name  = var.group_name
}

resource "aws_iam_group_membership" "group_membership" {
  name  = "${var.group_name}-membership"
  count = local.create_group
  users = var.group_user_names
  group = var.group_name
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  count      = length(var.group_policy_arns) * local.create_group
  group      = var.group_name
  policy_arn = var.group_policy_arns[count.index]
}

/* ************************************************************************* */

output "group_arn" {
  value       = join("", aws_iam_group.user_group.*.arn)
  description = "The ARN specifying the group."
}
