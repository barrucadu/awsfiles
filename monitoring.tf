locals {
  # can't send SMS messages from eu-west-2 (London), so set up SNS in
  # eu-west-1 (Ireland).
  "sns-region" = "eu-west-1"
}

variable "phone" {}
variable "email" {}

/* ************************************************************************* */

provider "aws" {
  alias      = "sns"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${local.sns-region}"
  version    = "~> 1.25"
}

resource "aws_sns_topic" "host-notifications" {
  provider = "aws.sns"
  name     = "host-notifications"
}

resource "aws_sns_topic_subscription" "host-notifications-sms" {
  provider  = "aws.sns"
  topic_arn = "${aws_sns_topic.host-notifications.arn}"
  protocol  = "sms"
  endpoint  = "${var.phone}"
}

## terraform cannot create the email subscription because it must be
## manually confirmed
# resource "aws_sns_topic_subscription" "host-notifications-email" {
#   provider  = "aws.sns"
#   topic_arn = "${aws_sns_topic.host-notifications.arn}"
#   protocol  = "email"
#   endpoint  = "${var.email}"
# }

/* ************************************************************************* */

variable "group_monitoring_user_names" {
  type = "list"
}

module "group_monitoring" {
  source                  = "./modules/group_user"
  group_name              = "monitoring"
  group_user_names        = ["${var.group_monitoring_user_names}"]
  group_policy_arns       = ["${aws_iam_policy.host-notifications.arn}"]
  group_policy_arns_count = 1
}

resource "aws_iam_policy" "host-notifications" {
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "${aws_sns_topic.host-notifications.arn}",
      "Action": [
        "sns:Publish"
      ]
    }
  ]
}
EOF
}
