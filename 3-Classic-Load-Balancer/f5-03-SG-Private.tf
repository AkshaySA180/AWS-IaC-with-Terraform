module "Private_SG" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"
  
  name = "Private-SG"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules = ["ssh-tcp", "http-80-tcp"]

  egress_rules = ["all-all"]
  tags = local.common_tags

}