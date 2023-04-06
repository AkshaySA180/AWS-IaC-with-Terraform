module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  domain_name  = trimsuffix(data.aws_route53_zone.dns_click.name, ".")
  zone_id      = data.aws_route53_zone.dns_click.zone_id

  subject_alternative_names = [
    "*.akshaydevops.click"
  ]

  wait_for_validation = true

  tags = local.common_tags

}