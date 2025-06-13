locals {
  application_subnet_ids_by_az = values(zipmap(data.aws_subnet.application[*].availability_zone, data.aws_subnet.application[*].id))

  common_tags = {
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
  }

  common_resource_name = "${var.environment}-${var.service_subtype}"
  dns_zone             = "${var.environment}.${var.dns_zone_suffix}"

  security_s3_data            = data.vault_generic_secret.security_s3_buckets.data
  session_manager_bucket_name = local.security_s3_data.session-manager-bucket-name
  
  shared_services_s3_data     = data.vault_generic_secret.shared_services_s3.data
  resources_bucket_name       = local.shared_services_s3_data["resources_bucket_name"]

  security_kms_keys_data = data.vault_generic_secret.security_kms_keys.data
  ssm_kms_key_id         = local.security_kms_keys_data.session-manager-kms-key-arn

  account_ids_secrets = jsondecode(data.vault_generic_secret.account_ids.data_json)

  kms_key       = data.vault_generic_secret.kms_key_alias.data
  kms_key_alias = local.kms_key["kms_key_alias"]

  sns_email_secret = data.vault_generic_secret.sns_email.data
  linux_sns_email = local.sns_email_secret["linux_email"]

  ami_owner = data.vault_generic_secret.ami_owner.data
  ami_owner_id = local.ami_owner["ami_owner"]

  ansible_inputs = {
    environment = var.environment
    region      = var.aws_region
    fqdn        = "${var.service_subtype}.${var.environment}.${var.dns_zone_suffix}"
    hostname    = var.service_subtype    
  }


}
