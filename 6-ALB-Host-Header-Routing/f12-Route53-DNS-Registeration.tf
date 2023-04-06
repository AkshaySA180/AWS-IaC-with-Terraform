resource "aws_route53_record" "dns_alias" {
  zone_id = data.aws_route53_zone.dns_click.zone_id
  name    = "apps.akshaydevops.click"
  type    = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}

# app1 DNS records in Route53
resource "aws_route53_record" "app1_dns" {
  zone_id = data.aws_route53_zone.dns_click.zone_id
  name    = var.app1_dns_name
  type    = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}

# app2 DNS records in Route53
resource "aws_route53_record" "app2_dns" {
  zone_id = data.aws_route53_zone.dns_click.zone_id
  name    = var.app2_dns_name
  type    = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}