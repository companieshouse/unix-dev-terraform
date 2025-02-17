resource "aws_route53_record" "linux_dev_03" {
  count = var.instance_count

  zone_id = data.aws_route53_zone.linux_dev_03.zone_id
  name    = "${var.service_subtype}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.linux_dev_03[0].private_ip]
}
