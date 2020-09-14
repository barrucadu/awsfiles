variable "phone" {}
# variable "email" {}

/* ************************************************************************* */

resource "aws_sns_topic" "host-notifications" {
  provider = "aws"
  name     = "host-notifications"
}

resource "aws_sns_topic_subscription" "host-notifications-sms" {
  provider  = "aws"
  topic_arn = aws_sns_topic.host-notifications.arn
  protocol  = "sms"
  endpoint  = var.phone
}

## terraform cannot create the email subscription because it must be
## manually confirmed
# resource "aws_sns_topic_subscription" "host-notifications-email" {
#   provider  = "aws"
#   topic_arn = aws_sns_topic.host-notifications.arn
#   protocol  = "email"
#   endpoint  = var.email
# }

/* ************************************************************************* */

variable "group_monitoring_user_names" {
  type = list(string)
}

module "group_monitoring" {
  source                  = "../../modules/group_user"
  group_name              = "monitoring"
  group_user_names        = var.group_monitoring_user_names
  group_policy_arns       = [aws_iam_policy.host-notifications.arn]
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
