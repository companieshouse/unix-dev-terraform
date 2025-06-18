resource "aws_security_group" "oracle_19_build" {
  name        = local.common_resource_name
  description = "Security group for the ${var.service_subtype} EC2 instances"
  vpc_id      = data.aws_vpc.heritage-development.id

  tags = merge(local.common_tags, {
    Name = "${local.common_resource_name}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "oracle_19_build_ssh" {
  description       = "Allow SSH connectivity for application deployments"
  security_group_id = aws_security_group.oracle_19_build.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.administration_cidr_ranges.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "oracle_19_build_snapcenter" {
  count = var.snapcenter ? 1 : 0
  
  description       = "Allow Netapp Snapcenter access"
  security_group_id = aws_security_group.oracle_19_build.id
  prefix_list_id    = data.vault_generic_secret.snapcenter_ip[0].data["ip"]
  ip_protocol       = "tcp"
  from_port         = 8145
  to_port           = 8146
}

resource "aws_vpc_security_group_egress_rule" "oracle_19_build_all_out" {
  description       = "Allow outbound traffic"
  security_group_id = aws_security_group.oracle_19_build.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

