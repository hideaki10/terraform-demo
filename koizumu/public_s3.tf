resource "aws_s3_bucket" "public" {
  bucket = "public-pragmatic-terrform-20210419"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    max_age_seconds = 3000
  }
}