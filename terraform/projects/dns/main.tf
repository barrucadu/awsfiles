resource "aws_iam_user" "user_dns" {
  name = "octodns"
}

module "group_dns" {
  source           = "../../modules/group_user"
  group_name       = "dns"
  group_user_names = [aws_iam_user.user_dns.name]

  group_policy_arns = [
    aws_iam_policy.tool_octodns.arn,
  ]
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
