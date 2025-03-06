resource "aws_route53_record" "rhel8_base_build" {
  count = var.instance_count

  zone_id = data.aws_route53_zone.rhel8_base_build.zone_id
  name    = "${var.service_subtype}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.rhel8_base_build[0].private_ip]
}
