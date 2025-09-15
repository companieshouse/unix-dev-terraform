output "availability_zone" {
  value = aws_instance.linux_dev_01[0].availability_zone
}