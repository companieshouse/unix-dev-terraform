resource "aws_cloudwatch_metric_alarm" "smtpcpu90" {
  alarm_name                = "WARNING-dev-node-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_system"
  namespace                 = "dev/unix"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "smtpcpuuser90" {
  alarm_name                = "WARNING-dev-node-CPUUtilizationUser"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_user"
  namespace                 = "dev/unix"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization user"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "smtpcpu95" {
  
  alarm_name                = "CRITICAL-dev-node-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_system"
  namespace                 = "dev/unix"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "smtpcpu95user" {
  
  alarm_name                = "CRITICAL-dev-node-CPUUtilizationUser"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "cpu_usage_user"
  namespace                 = "dev/unix"
  period                    = "30"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization user"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "smtpswap90" {
  
  alarm_name                = "WARNING-dev-node-SwapUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "swap_used_percent"
  namespace                 = "dev/unix"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors swap utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "smtpswap95" {
  
  alarm_name                = "CRITICAL-dev-node-SwapUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "swap_used_percent"
  namespace                 = "dev/unix"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors swap utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "mem_used90" {
  
  alarm_name                = "WARNING-dev-node-mem_used"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "mem_used_percent"
  namespace                 = "dev/unix"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "90"
  alarm_description         = "This metric monitors memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "mem_used95" {
  
  alarm_name                = "CRITICAL-dev-node-mem_used"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "mem_used_percent"
  namespace                 = "dev/unix"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors memory utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "ec2_instancedisks_low_space" {
    
  
    alarm_name                = "WARNING-dev-node-disk_used"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = "2"
    metric_name               = "disk_used_percent"
    namespace                 = "dev/unix"
    period                    = "30"
    statistic                 = "Average"
    threshold                 = "90"
    alarm_description         = "This metric monitors root disk utilization"
    insufficient_data_actions = []
    alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
    ok_actions                = [aws_sns_topic.SMTP_topic.arn]
    treat_missing_data        = "notBreaching"
  
    dimensions = {
      InstanceId = aws_instance.dev_node.id
      path       = "/"
      device     = "xvda1"
      fstype     = "ext4"
      ImageId = "ami-09b93cc9c91e4ee20"
      InstanceType = "t2.micro"
    }
      depends_on = [
    aws_instance.dev_node
  ]
}

resource "aws_cloudwatch_metric_alarm" "StatusCheckFailed" {
  
  alarm_name                = "CRITICAL-dev-node-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.SMTP_topic.arn]
  ok_actions                = [aws_sns_topic.SMTP_topic.arn]

    dimensions = {
    InstanceId = aws_instance.dev_node.id
  }
  depends_on = [
    aws_instance.dev_node
  ]
}





























