data "aws_ec2_managed_prefix_list" "administration_cidr_ranges" {
  name = "administration-cidr-ranges"
}

data "aws_kms_alias" "ebs" {
  name = local.kms_key_alias
}

data "vault_generic_secret" "kms_key_alias" {
  path = "applications/${var.aws_account}-${var.aws_region}/${var.service}/${var.service_subtype}"
}

data "aws_vpc" "heritage-development" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.aws_account}"]
  }
}

data "aws_route53_zone" "linux_dev_01" {
  name   = local.dns_zone
  vpc_id = data.aws_vpc.heritage-development.id
}

data "vault_generic_secret" "internal_cidrs" {
  path = "aws-accounts/network/internal_cidr_ranges"
}

data "aws_subnets" "application" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.heritage-development.id]
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

data "aws_ami" "linux_dev_ami" {
  most_recent = true
  name_regex  = "^rhel9-base-\\d.\\d.\\d"

  filter {
    name   = "name"
    values = ["rhel9-base-${var.ami_version_pattern}"]
  }

  filter {
    name  = "owner-id"
    values = ["${local.ami_owner_id}"]
  }
}

data "vault_generic_secret" "ami_owner" {
  path = "/applications/${var.aws_account}-${var.aws_region}/${var.service}/${var.service_subtype}"
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
  path = "/applications/${var.aws_account}-${var.aws_region}/${var.service}/sns/"
}

data "vault_generic_secret" "sns_url" {
  path = "/applications/${var.aws_account}-${var.aws_region}/${var.service}/sns/"
}

data "template_file" "userdata" {
  template = file("${path.module}/templates/user_data.tpl")

  count = var.instance_count

  vars = { 
    ENVIRONMENT          = title(var.environment)
    HOSTNAME             = local.ansible_inputs.fqdn
  }
}
