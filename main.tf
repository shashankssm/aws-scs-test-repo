provider "aws" {
  region = env("AWS_DEFAULT_REGION")
}

#######################################
# S3 Bucket
#######################################

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Demo"
    ManagedBy   = "Terraform"
  }
}

#######################################
# IAM User
#######################################

resource "aws_iam_user" "user" {
  name = var.iam_username
}

#######################################
# Access Key
#######################################

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

#######################################
# IAM Policy
#######################################

resource "aws_iam_policy" "bucket_read_policy" {
  name = "${var.iam_username}-s3-read"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = [
          aws_s3_bucket.bucket.arn
        ]
      },
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      }
    ]
  })
}

#######################################
# Attach Policy
#######################################

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.bucket_read_policy.arn
}
