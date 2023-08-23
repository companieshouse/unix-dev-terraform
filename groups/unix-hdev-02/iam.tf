module "instance_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.88"

  name       = format("%s", var.application)
  enable_SSM = true
  kms_key_refs = [
    "alias/${var.account}/${var.region}/ebs",
    local.ssm_kms_key_id,
    local.ssm_logs_key_id,
  ]
  s3_buckets_read = [
    local.resources_bucket_name,
  ]
  s3_buckets_write = [
    local.session_manager_bucket_name,
    local.ssm_data.ssm_logs_bucket_name
  ]
  cw_log_group_arns = length(local.log_groups) > 0 ? flatten([
    formatlist(
      "arn:aws:logs:%s:%s:log-group:%s:*:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      concat(local.log_groups, var.cloudwatch_oracle_log_groups)
    ),
    formatlist("arn:aws:logs:%s:%s:log-group:%s:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      concat(local.log_groups, var.cloudwatch_oracle_log_groups)
    ),
  ]) : null
}