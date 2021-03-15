resource "aws_iam_user" "user_concourse" {
  name = "concourse"
}

resource "aws_iam_user_policy_attachment" "manage_concourse_ssm" {
  user       = aws_iam_user.user_concourse.name
  policy_arn = aws_iam_policy.tool_concourse.arn
}

resource "aws_kms_key" "concourse" {
  description = "Key for Concourse secrets"
}

resource "aws_iam_policy" "tool_concourse" {
  policy = data.aws_iam_policy_document.tool_concourse.json
}

data "aws_iam_policy_document" "tool_concourse" {
  statement {
    sid = "ssm"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParametersByPath",
      "ssm:PutParameter",
    ]

    resources = [
      # "arn:aws:ssm:::parameter/..." doesn't seem to work in this
      # policy, but specifying the account ID explicitly does.
      "arn:aws:ssm:eu-west-1:${var.aws_account_id}:parameter/concourse",
      "arn:aws:ssm:eu-west-1:${var.aws_account_id}:parameter/concourse/*",
    ]
  }

  statement {
    sid = "usekms"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = [
      aws_kms_key.concourse.arn
    ]
  }

  statement {
    sid = "listkms"

    actions = [
      "kms:ListAliases",
      "kms:ListKeys",
    ]

    resources = [
      "*"
    ]
  }
}
