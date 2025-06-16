resource "aws_cloudwatch_metric_alarm" "linux_dev_03_server_cpu95" {
  count = var.monitoring ? 1 : 0
  
  alarm_name                = "WARNING-linux-dev-03-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "linux-dev-03/EC2"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.linux_dev_03[0].arn]
  ok_actions                = [aws_sns_topic.linux_dev_03[0].arn]
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_03_server_StatusCheckFailed" {
  count = var.monitoring ? 1 : 0
  
  alarm_name                = "CRITICAL-linux-dev-03-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "linux-dev-03/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.linux_dev_03[0].arn]
  ok_actions                = [aws_sns_topic.linux_dev_03[0].arn]
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_03_server_disk_space" {
  count = var.monitoring ? 1 : 0
  
  alarm_name          = "CRITICAL-linux-dev-03-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "linux-dev-03/EC2"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precetage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.linux_dev_03[0].arn]
  ok_actions          = [aws_sns_topic.linux_dev_03[0].arn]
  dimensions = {
    path         = "*"
  }
}

resource "aws_cloudwatch_metric_alarm" "linux_dev_03_server_root_disk_space" {
  count = var.monitoring ? 1 : 0
  
  alarm_name          = "WARNING-linux-dev-03-root-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "linux-dev-03/EC2"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precetage is over 80% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.linux_dev_03[0].arn]
  ok_actions          = [aws_sns_topic.linux_dev_03[0].arn]
  dimensions = {
    path         = "/"
  }
}
