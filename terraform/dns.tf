resource "aws_iam_user" "user_dns" {
  name = "octodns"
}

resource "aws_iam_user_policy_attachment" "manage_dns" {
  user       = aws_iam_user.user_dns.name
  policy_arn = aws_iam_policy.tool_octodns.arn
}

resource "aws_iam_policy" "tool_octodns" {
  name   = "tool_octodns"
  policy = data.aws_iam_policy_document.tool_octodns.json
}

data "aws_iam_policy_document" "tool_octodns" {
  statement {
    actions = [
      "route53:*",
    ]

    resources = [
      "*",
    ]
  }
}
