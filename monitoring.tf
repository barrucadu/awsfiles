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
