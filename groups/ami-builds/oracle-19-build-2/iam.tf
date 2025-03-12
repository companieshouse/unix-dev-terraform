module "instance_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.283"
  name   = local.common_resource_name

  enable_ssm       = true
  kms_key_refs     = [local.ssm_kms_key_id]
  

  custom_statements = [
    {
      sid       = "CloudWatchMetricsWrite"
      effect    = "Allow"
      resources = ["*"]
      actions = [
        "cloudwatch:PutMetricData"
      ]
    },
    
    {
      sid       = "AllowDescribeTags",
      effect    = "Allow",
      resources = ["*"],
      actions = [
          "ec2:DescribeTags"
      ]
    },
    
    {
      sid       = "AllowS3HighLevel",
      effect    = "Allow",
      resources = ["*"],
      actions = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
          "s3:ListBucket"
      ]
    }
  ]
}
