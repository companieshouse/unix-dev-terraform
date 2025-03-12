resource "aws_route53_record" "oracle_19_build_2" {
  count = var.instance_count

  zone_id = data.aws_route53_zone.oracle_19_build_2.zone_id
  name    = "${var.service_subtype}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.oracle_19_build_2[0].private_ip]
}
