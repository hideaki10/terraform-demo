resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket                  = "aws_s3_bucket_private_20210419"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

