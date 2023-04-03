module "Bastion_SG" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name = "Bastion-SG"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]
  
  egress_rules = ["all-all"]

  tags = local.common_tags

}