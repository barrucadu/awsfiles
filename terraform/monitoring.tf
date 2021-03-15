resource "aws_sns_topic" "host-notifications" {
  name     = "host-notifications"
}

resource "aws_sns_topic_subscription" "host-notifications-sms" {
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

resource "aws_iam_user" "user_monitoring" {
  name = "monitoring-scripts"
}

resource "aws_iam_user_policy_attachment" "monitoring_notifications" {
  user       = aws_iam_user.user_monitoring.name
  policy_arn = aws_iam_policy.host-notifications.arn
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
