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

resource "aws_route53_record" "dns_alias2" {
  zone_id = data.aws_route53_zone.dns_click.zone_id
  name    = "linkedin.akshaydevops.click"
  type    = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}
