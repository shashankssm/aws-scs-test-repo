output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "iam_username" {
  value = aws_iam_user.user.name
}

output "access_key_id" {
  value = aws_iam_access_key.user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.user_key.secret
  sensitive = true
}
