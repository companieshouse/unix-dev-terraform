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

  name              = "unix-hdev-01cloudwatch-ooh"
  display_name      = "unix-hdev-01cloudwatch-alarms-ooh-only"
  kms_master_key_id = local.sns_kms_key_id

  tags = merge(
    local.default_tags,
    map(
      "ServiceTeam", "UNIX"
    )
  )
}