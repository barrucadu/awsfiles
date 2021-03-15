variable "aws_account_id" {
  type = string
}

resource "aws_iam_user" "user_concourse" {
  name = "concourse"
}

module "group_concourse" {
  source           = "../../modules/group_user"
  group_name       = "concourse"
  group_user_names = [aws_iam_user.user_concourse.name]

  group_policy_arns = [
    aws_iam_policy.tool_concourse.arn,
  ]
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
      "arn:aws:ssm:eu-west-2:${var.aws_account_id}:parameter/concourse",
      "arn:aws:ssm:eu-west-2:${var.aws_account_id}:parameter/concourse/*",
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

output "key_arn" {
  value = aws_kms_key.concourse.arn
}
