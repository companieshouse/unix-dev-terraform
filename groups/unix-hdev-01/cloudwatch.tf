module "cloudwatch-alarms" {
  source = "git@github.com:companieshouse/terraform-modules//aws/ec2-cloudwatch-alarms?ref=tags/1.0.123"
  count  = var.instance_count

  name_prefix               = "unix-dev-01"
  namespace                 = var.cloudwatch_namespace
  instance_id               = aws_instance[count.index].id
  status_evaluation_periods = "3"
  status_statistics_period  = "60"

  cpuutilization_evaluation_periods = "2"
  cpuutilization_statistics_period  = "60"
  cpuutilization_threshold          = "75" # Percentage

  enable_disk_alarms = true
  disk_devices = [
    {
      instance_device_mount_path = "/"
      instance_device_location   = "xvda2"
      instance_device_fstype     = "xfs"
    }
    {
      instance_device_mount_path = "/mnt/netapp"
      instance_device_location   = ""
      instance_device_fstype     = "xfs"
    }
  ]
  disk_evaluation_periods = "3"
  disk_statistics_period  = "120"
  low_disk_threshold      = "75" # Percentage

  enable_memory_alarms       = true
  memory_evaluation_periods  = "2"
  memory_statistics_period   = "120"
  available_memory_threshold = "10" # Percentage
  used_memory_threshold      = "80" # Percentage
  used_swap_memory_threshold = "50" # Percentage

  alarm_actions = [
    module.cloudwatch_sns_notifications.sns_topic_arn
  ]

  ok_actions = [
    module.cloudwatch_sns_notifications.sns_topic_arn
  ]

  depends_on = [
    aws_instance.db_ec2,
    module.cloudwatch_sns_notifications
  ]

  tags = merge(
    local.default_tags,
    tomap({
      "ServiceTeam" = "Linux/Storage",
      "Terraform"   = true
    })
  )
}