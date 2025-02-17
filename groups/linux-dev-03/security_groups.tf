resource "aws_security_group" "linux_dev_02" {
  name        = local.common_resource_name
  description = "Security group for the ${var.service_subtype} EC2 instances"
  vpc_id      = data.aws_vpc.heritage-development.id

  tags = merge(local.common_tags, {
    Name = "${local.common_resource_name}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "linux_dev_02_ssh" {
  description       = "Allow SSH connectivity for application deployments"
  security_group_id = aws_security_group.linux_dev_02.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.administration_cidr_ranges.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "linux_dev_02_all_out" {
  description       = "Allow outbound traffic"
  security_group_id = aws_security_group.linux_dev_02.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

