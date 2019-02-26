resource "aws_s3_bucket" "backup" {
  bucket = "barrucadu-backups"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "archive"
    enabled = true

    transition {
      days          = 60
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 120
      storage_class = "GLACIER"
    }
  }
}

/* ************************************************************************* */

variable "group_backup_user_names" {
  type = "list"
}

module "group_backup" {
  source           = "../../modules/group_user"
  group_name       = "backup"
  group_user_names = ["${var.group_backup_user_names}"]

  group_policy_arns_count = 1
  group_policy_arns       = [
    "${aws_iam_policy.tool_duplicity.arn}",
  ]
}

resource "aws_iam_policy" "tool_duplicity" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload",
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
             ],
            "Resource": [
                "${aws_s3_bucket.backup.arn}",
                "${aws_s3_bucket.backup.arn}/*"
            ]
        }
    ]
}
EOF
}
