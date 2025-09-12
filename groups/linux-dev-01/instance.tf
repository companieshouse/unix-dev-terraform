resource "aws_instance" "linux_dev_01" {
  count = var.instance_count

  ami           = data.aws_ami.linux_dev_ami.id
  instance_type = var.instance_type
  subnet_id     = element(local.application_subnet_ids_by_az, count.index) # use 'element' function for wrap-around behaviour

  iam_instance_profile   = module.instance_profile.aws_iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.linux_dev_01.id]
  tags = {
    Name           = local.common_resource_name
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
    Domain         = "${var.environment}.${var.dns_zone_suffix}"
    Hostname       = "${var.service_subtype}"
    Repository     = var.origin
  }

  root_block_device {
    volume_size = var.root_volume_size
    encrypted   = var.encrypt_root_block_device
    iops        = var.root_block_device_iops
    kms_key_id  = data.aws_kms_alias.ebs.target_key_arn
    throughput  = var.root_block_device_throughput
    volume_type = var.root_block_device_volume_type
    tags = {
      Name           = "${local.common_resource_name}-root"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }
  }
    user_data = data.template_file.userdata[count.index].rendered
}

resource "aws_ebs_volume" "data" {
  availability_zone     = var.aws_region
  size                  = var.data_volume_size_gib
  encrypted             = var.encrypt_ebs_block_device
  iops                  = var.ebs_block_device_iops
  kms_key_id            = data.aws_kms_alias.ebs.target_key_arn
  throughput            = var.ebs_block_device_throughput
  type                  = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-data"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "data_att" {
  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.linux_dev_01[0].id
}

resource "aws_ebs_volume" "data2" {
  availability_zone     = var.aws_region
  size                  = var.data_volume_size_gib
  encrypted             = var.encrypt_ebs_block_device
  iops                  = var.ebs_block_device_iops
  kms_key_id            = data.aws_kms_alias.ebs.target_key_arn
  throughput            = var.ebs_block_device_throughput
  type                  = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-data2"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "data2_att" {
  device_name = var.ebs_device_name_2
  volume_id   = aws_ebs_volume.data2.id
  instance_id = aws_instance.linux_dev_01[0].id
}
