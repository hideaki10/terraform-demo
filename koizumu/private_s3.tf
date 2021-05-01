
resource "aws_s3_bucket" "s3_private_bucket" {
  bucket = "s3_private_bucker_20210419171714"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
