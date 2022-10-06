resource "aws_sns_topic" "SMTP_topic" {
  name = "SMTP_topic"
}

resource "aws_sns_topic_subscription" "SMTP_Subscription" {
  topic_arn = aws_sns_topic.SMTP_topic.arn
  for_each  = toset(["YOUREMAIL"])
  protocol  = "email"
  endpoint  = each.value

  depends_on = [
    aws_sns_topic.SMTP_topic
  ]
}

resource "aws_sns_topic_subscription" "SMTP_Subscriptionhttps" {
  topic_arn = aws_sns_topic.SMTP_topic.arn
  protocol  = "https"
  endpoint  = "https://companieshouse.xmatters.com/api/integration/1/functions/663f6327-04ae-46ab-8e8d-f5[…]Key=850133a0-4cae-477e-9b69-c0cbc8154d8c&recipients=unix"

  depends_on = [
    aws_sns_topic.SMTP_topic
  ]
}