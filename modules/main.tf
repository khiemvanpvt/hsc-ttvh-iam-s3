data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.common_name
  tags   = local.common_tags
}

resource "aws_s3_bucket_acl" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

resource "aws_iam_user" "user" {
  name = local.common_name
  tags = local.common_tags
}

resource "aws_iam_role" "role" {
  name               = local.common_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "S3_Full_Access"
    effect = "Allow"
    actions = [
      "s3:GetBucketTagging",
      "s3:PutBucketTagging",
      "s3:PutBucketPolicy",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:DeleteObjectTagging",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::${local.common_name}",
      "arn:aws:s3:::${local.common_name}/*"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = local.common_name
  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = local.common_name
  users      = [aws_iam_user.user.name]
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy.arn
}
