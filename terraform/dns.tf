resource "aws_iam_user" "user_dns" {
  name = "octodns"
}

resource "aws_iam_user_policy_attachment" "manage_dns" {
  user       = aws_iam_user.user_dns.name
  policy_arn = aws_iam_policy.tool_octodns.arn
}

resource "aws_iam_policy" "tool_octodns" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
