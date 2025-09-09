resource "aws_cloudwatch_metric_alarm" "linux_dev_01_server_cpu95" {
  count = var.monitoring ? 1 : 0
  
  alarm_name                = "WARNING-linux-dev-01-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.linux_dev_01[0].arn]
  ok_actions                = [aws_sns_topic.linux_dev_01[0].arn]
  dimensions = {
    InstanceId              = aws_instance.linux_dev_01[0].id
  }
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_01_server_StatusCheckFailed" {
  count = var.monitoring ? 1 : 0
  
  alarm_name                = "CRITICAL-linux-dev-01-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.linux_dev_01[0].arn]
  ok_actions                = [aws_sns_topic.linux_dev_01[0].arn]
  dimensions = {
    InstanceId              = aws_instance.linux_dev_01[0].id
  }
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_01_server_disk_space_ebs1" {
  count = var.monitoring ? 1 : 0

  alarm_name          = "CRITICAL_linux_dev_01_%_used_ebs_vol_1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precetage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.linux_dev_01[0].arn]
  ok_actions          = [aws_sns_topic.linux_dev_01[0].arn]
  dimensions = {
    path              = local.disk_info.ebs_vol_1.path
    InstanceId        = aws_instance.linux_dev_01[0].id
    ImageId           = data.aws_ami.linux_dev_ami.id
    InstanceType      = var.instance_type
    device            = local.disk_info.ebs_vol_1.device
    fstype            = local.disk_info.ebs_vol_1.fstype
  }
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_01_server_disk_spac_ebs_vol_2" {
  count = var.monitoring ? 1 : 0
  
  alarm_name          = "CRITICAL_linux_dev_01_%_used_ebs_vol_2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precetage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.linux_dev_01[0].arn]
  ok_actions          = [aws_sns_topic.linux_dev_01[0].arn]
  dimensions = {
    path              = local.disk_info.ebs_vol_2.path
    InstanceId        = aws_instance.linux_dev_01[0].id
    ImageId           = data.aws_ami.linux_dev_ami.id
    InstanceType      = var.instance_type
    device            = local.disk_info.ebs_vol_2.device
    fstype            = local.disk_info.ebs_vol_2.fstype
  }
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_01_server_root_disk_space" {
  count = var.monitoring ? 1 : 0
  
  alarm_name          = "CRITICAL_linux_dev_01_%_used_root_vol"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precetage is over 80% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.linux_dev_01[0].arn]
  ok_actions          = [aws_sns_topic.linux_dev_01[0].arn]
  dimensions = {
    path              = local.disk_info.root_vol.path
    InstanceId        = aws_instance.linux_dev_01[0].id
    ImageId           = data.aws_ami.linux_dev_ami.id
    InstanceType      = var.instance_type
    device            = local.disk_info.root_vol.device
    fstype            = local.disk_info.root_vol.fstype
  }
}
