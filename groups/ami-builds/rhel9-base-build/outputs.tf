output "ami_is" {
  value = aws_instance.rhel9_base_build[0].ami
}