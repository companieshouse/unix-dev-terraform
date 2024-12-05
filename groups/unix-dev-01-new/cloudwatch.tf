resource "aws_cloudwatch_metric_alarm" "uninx_dev_01_server_cpu95" {
  alarm_name                = "WARNING-unix-dev-01-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "UNIX-DEV-01/EC2"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.unix_dev_01.arn]
  ok_actions                = [aws_sns_topic.unix_dev_01.arn]
}

resource "aws_cloudwatch_metric_alarm" "unix_dev_01_server_StatusCheckFailed" {
  alarm_name                = "CRITICAL-unxi-dev-01-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "UNIX-DEV-01/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.unix_dev_01.arn]
  ok_actions                = [aws_sns_topic.unix_dev_01.arn]
}

resource "aws_cloudwatch_metric_alarm" "unix_dev_01_server_disk_space" {
  alarm_name          = "CRITICAL-unix-dev-01-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "UNIX-DEV-01/EC2"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precetage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.unix_dev_01.arn]
  ok_actions          = [aws_sns_topic.unix_dev_01.arn]
  dimensions = {
    path         = "*"
  }
}

resource "aws_cloudwatch_metric_alarm" "unix_dev_01_server_root_disk_space" {
  alarm_name          = "WARNING-unix-dev-01-root-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "UNIX-DEV-01/EC2"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precetage is over 80% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.unix_dev_01.arn]
  ok_actions          = [aws_sns_topic.unix_dev_01.arn]
  dimensions = {
    path         = "/"
  }
}
