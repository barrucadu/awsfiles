resource "aws_glacier_vault" "backup" {
  name = "backup"
}

/* ************************************************************************* */

variable "group_backup_user_names" {
  type = "list"
}

module "group_backup" {
  source                  = "../../modules/group_user"
  group_name              = "backup"
  group_user_names        = ["${var.group_backup_user_names}"]
  group_policy_arns       = ["${aws_iam_policy.backup.arn}"]
  group_policy_arns_count = 1
}

resource "aws_iam_policy" "backup" {
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "${aws_glacier_vault.backup.arn}",
      "Action": [
        "glacier:UploadArchive",
        "glacier:InitiateMultipartUpload",
        "glacier:UploadMultipartPart",
        "glacier:ListParts",
        "glacier:ListMultipartUploads",
        "glacier:CompleteMultipartUpload"
      ]
    }
  ]
}
EOF
}
