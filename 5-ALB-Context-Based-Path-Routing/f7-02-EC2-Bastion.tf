module "Bastion_EC2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  name = "Bastion-Instance"
  ami = data.aws_ami.ec2linux.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.Bastion_SG.security_group_id]
  
  tags = local.common_tags
}