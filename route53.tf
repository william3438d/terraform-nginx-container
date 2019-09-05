resource "aws_route53_zone" "william-lab" {
  name = "william-lab.dev"
}

resource "aws_route53_record" "www-record" {
  zone_id = aws_route53_zone.william-lab.zone_id
  name    = "www.william-lab.dev"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.web_ec2.public_ip}"]
}

output "ns-servers" {
  value = aws_route53_zone.william-lab.name_servers
}
