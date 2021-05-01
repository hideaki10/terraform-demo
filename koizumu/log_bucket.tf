# resource "aws_s3_bucket" "alb_log" {
#   bucket = "alb_log_pragmatic_terraform"

#   lifecycle_rule {
#     enabled = true

#     expiration {
#       date = "180"
#     }
#   }


# }


resource "aws_s3_bucket" "alb_log" {
  bucket = "alb-log-pragmatic-terraform"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}
#bucket policy
resource "aws_s3_bucket_policy" "alb_log_policy" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

#alb log of bucket
data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["aws account id"]
    }
  }
}

#強制削除s
resource "aws_s3_bucket" "force_destory" {
  bucket        = "force-destory-pargmatic-terraform"
  force_destroy = true

}
