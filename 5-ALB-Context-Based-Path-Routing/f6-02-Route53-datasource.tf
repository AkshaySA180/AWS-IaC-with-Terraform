data "aws_route53_zone" "dns_click" {
  name         = "akshaydevops.click"
  private_zone = false
}

output "mydomain_id" {
  value = data.aws_route53_zone.dns_click.id
}

output "mydomain_name" {
  value = data.aws_route53_zone.dns_click.name
}