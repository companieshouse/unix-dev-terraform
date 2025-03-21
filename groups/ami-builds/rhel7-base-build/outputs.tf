output "ami_is" {
  value = aws_instance.rhel7_base_build[0].ami
}