resource "aws_instance" "unix-dev-01" {
  count = var.instance_count

  ami           = data.aws_ami.unix_dev_ami.id
  instance_type = var.instance_type
  subnet_id     = element(local.application_subnet_ids_by_az, count.index) # use 'element' function for wrap-around behaviour

  iam_instance_profile   = module.instance_profile.aws_iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.e5_lfp.id]
  tags = {
    Name           = "${local.common_resource_name}-${count.index + 1}"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }

  root_block_device {
    volume_size = var.root_volume_size
    encrypted   = var.encrypt_root_block_device
    iops        = var.root_block_device_iops
    kms_key_id  = data.aws_kms_alias.ebs.target_key_arn
    throughput  = var.root_block_device_throughput
    volume_type = var.root_block_device_volume_type
    tags = {
      Name           = "${local.common_resource_name}-${count.index + 1}-root"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }

  }

  # ebs_block_device {
  #   device_name           = var.ebs_device_name
  #   volume_size           = var.data_volume_size_gib
  #   encrypted             = var.encrypt_ebs_block_device
  #   iops                  = var.ebs_block_device_iops
  #   kms_key_id            = data.aws_kms_alias.ebs.target_key_arn
  #   throughput            = var.ebs_block_device_throughput
  #   volume_type           = var.ebs_block_device_volume_type
  #   delete_on_termination = var.ebs_delete_on_termination
  #   tags = {
  #     Name           = "${local.common_resource_name}-${count.index + 1}-data"
  #     Environment    = var.environment
  #     Service        = var.service
  #     ServiceSubType = var.service_subtype
  #     Team           = var.team
  #     Backup         = true
  #   }
  #}
}
