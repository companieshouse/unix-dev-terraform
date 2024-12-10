resource "aws_sns_topic" "unix_dev_01" {
  name = "unix-dev-01"
}

resource "aws_sns_topic_subscription" "unix_dev_01_system_Subscription" {
  topic_arn = aws_sns_topic.unix_dev_01.arn
  protocol  = "email"
  endpoint = local.linux_sns_email

  depends_on = [
    aws_sns_topic.unix_dev_01
  ]
}

resource "aws_sns_topic_subscription" "unix_dev_01_system_Subscriptionhttps" {
  topic_arn = aws_sns_topic.unix_dev_01.arn
  protocol  = "https"
  endpoint  = data.vault_generic_secret.sns_url.data["linux_url"]

  depends_on = [
    aws_sns_topic.unix_dev_01
  ]
}
