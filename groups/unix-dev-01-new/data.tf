data "aws_ec2_managed_prefix_list" "administration_cidr_ranges" {
  name = "administration-cidr-ranges"
}

data "aws_kms_alias" "ebs" {
  name = local.kms_key_alias
}

data "vault_generic_secret" "kms_key_alias" {
  path = "applications/${var.aws_account}-${var.aws_region}/e5"
}

data "aws_route53_zone" "e5_lfp" {
  name   = local.dns_zone
  vpc_id = data.aws_vpc.finance.id
}

data "aws_vpc" "heritage-development" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.environment}"]
  }
}

data "vault_generic_secret" "internal_cidrs" {
  path = "aws-accounts/network/internal_cidr_ranges"
}

data "aws_subnets" "application" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.application_subnet_pattern]
  }
}

data "aws_subnet" "application" {
  count = length(data.aws_subnets.application.ids)
  id    = tolist(data.aws_subnets.application.ids)[count.index]
}

data "aws_ami" "unix_dev_ami" {
  most_recent = true
  name_regex  = "^rhel8-base-ami-\\d.\\d.\\d"

  filter {
    name   = "name"
    values = ["rhel8-base-ami-${var.ami_version_pattern}"]
  }
}

data "vault_generic_secret" "account_ids" {
  path = "aws-accounts/account-ids"
}

data "vault_generic_secret" "kms_keys" {
  path = "aws-accounts/${var.aws_account}/kms"
}

data "vault_generic_secret" "security_s3_buckets" {
  path = "aws-accounts/security/s3"
}

data "vault_generic_secret" "security_kms_keys" {
  path = "aws-accounts/security/kms"
}

data "vault_generic_secret" "shared_services_s3" {
  path = "aws-accounts/shared-services/s3"
}

data "vault_generic_secret" "sns_email" {
  path = "/applications/${var.aws_account}-${var.aws_region}/sns"
}

data "vault_generic_secret" "sns_url" {
  path = "/applications/${var.aws_account}-${var.aws_region}/sns"
}
