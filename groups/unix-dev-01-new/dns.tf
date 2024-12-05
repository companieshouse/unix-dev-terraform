resource "aws_route53_record" "unix-dev-01" {
  count = var.instance_count

  zone_id = data.aws_route53_zone.unix_dev_01.zone_id
  name    = "${var.service_subtype}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.unix_dev_01.private_ip]
}
