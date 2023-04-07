resource "aws_eip" "bastion_eip" {
  vpc                       = true
  depends_on                = [module.Bastion_EC2, module.vpc.id]
  instance                  = module.Bastion_EC2.id
  #associate_with_private_ip = "10.0.0.12"  
  tags = local.common_tags
}