output "ami_is" {
  value = aws_instance.rhel8_base_build[0].ami
}