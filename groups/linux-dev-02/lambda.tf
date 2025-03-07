module "stop_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_stop"
  cloudwatch_schedule_expression = "cron(0 0 ? * FRI *)"
  schedule_action                = "stop"
  ec2_schedule                   = "true"
  scheduler_tag                  = {
    key   = "WorkingHoursOnly"
    value = true
  }
}

module "start_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_start"
  cloudwatch_schedule_expression = "cron(0 8 ? * MON *)"
  schedule_action                = "start"
  ec2_schedule                   = "true"
  scheduler_tag                  = {
    key   = "WorkingHoursOnly"
    value = true
  }
}