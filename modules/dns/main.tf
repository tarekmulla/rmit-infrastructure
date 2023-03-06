resource "aws_route53_zone" "app" {
  name = var.domain
}


# Add record in the main domain route53 zone to point to the application domain
data "aws_route53_zone" "parent" {
  name = var.parent_domain
}

resource "aws_route53_record" "point_to_app_route53" {
  zone_id = data.aws_route53_zone.parent.zone_id
  name    = var.domain
  type    = "NS"
  ttl     = "300"
  records = aws_route53_zone.app.name_servers
}
