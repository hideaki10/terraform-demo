
// cloudwatch通知のため sns topicを作成
module "admin-sns-email-topic" {
  version       = "1.0.0"
  source        = "github.com/deanwilson/tf_sns_email"
  display_name  = "exaple.org admin notifications"
  email_address = "senshikou1985@gmail.com"
  stack_name    = "admin-sns-email"
}
