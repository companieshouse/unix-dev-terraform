resource "aws_sns_topic" "linux_dev_03" {
  count = var.monitoring ? 1 : 0
  name = "linux-dev-03"
}

resource "aws_sns_topic_subscription" "linux_dev_03_system_Subscription" {
  count = var.monitoring ? 1 : 0
  topic_arn = aws_sns_topic.linux_dev_03[0].arn
  protocol  = "email"
  endpoint = local.linux_sns_email

  depends_on = [
    aws_sns_topic.linux_dev_03
  ]
}

resource "aws_sns_topic_subscription" "linux_dev_03_system_Subscriptionhttps" {
  count = var.monitoring ? 1 : 0
  topic_arn = aws_sns_topic.linux_dev_03[0].arn
  protocol  = "https"
  endpoint  = data.vault_generic_secret.sns_url.data["linux_url"]

  depends_on = [
    aws_sns_topic.linux_dev_03
  ]
}
