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
      days          = 32
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 64
      storage_class = "GLACIER"
    }
  }
}

/* ************************************************************************* */

resource "aws_iam_user" "user_backup" {
  name = "backup-scripts"
}

resource "aws_iam_user_policy_attachment" "create_backups" {
  user       = aws_iam_user.user_backup.name
  policy_arn = aws_iam_policy.tool_duplicity.arn
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
