module "cloudwatch_sns_notifications" {

  source  = "terraform-aws-modules/sns/aws"
  version = "3.3.0"

  name              = "unix-hdev-01-cloudwatch-emails"
  display_name      = "unix-hdev-01-cloudwatch-alarms-emails-only"
  kms_master_key_id = local.sns_kms_key_id

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "UNIX"
    )
  )
}

module "cloudwatch_sns_notifications_ooh" {

  source  = "terraform-aws-modules/sns/aws"
  version = "3.3.0"

  name              = "unix-hdev-01-cloudwatch-ooh"
  display_name      = "unix-hdev-01-cloudwatch-alarms-ooh-only"
  kms_master_key_id = local.sns_kms_key_id

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "UNIX"
    )
  )
}


resource "aws_sns_topic" "unix-dev-01_topic" {
  name = "unix-dev-01_topic"
}

# resource "aws_sns_topic_subscription" "unix-dev-01_Subscription" {
#   topic_arn = aws_sns_topic.unix-dev-01_topic.arn
#   for_each  = toset(["linuxsupport@companieshouse.gov.uk"])
#   protocol  = "email"
#   endpoint  = each.value

#   depends_on = [
#     aws_sns_topic.unix-dev-01_topic
#   ]
# }

# resource "aws_sns_topic_subscription" "unix-dev-01_Subscriptionhttps" {
#   topic_arn = aws_sns_topic.unix-dev-01_topic.arn
#   protocol  = "https"
#   endpoint  = data.vault_generic_secret.sns_url.data["url"]

#   depends_on = [
#     aws_sns_topic.unix-dev-01_topic
#   ]
# }