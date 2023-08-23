output "dev_ip" {
  description = "Output the public IP of the dev node instance"
  value = aws_instance.dev_node.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.dev_node.id
}