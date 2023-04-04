module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs = var.vpc_az
  private_subnets     = var.vpc_public_subnets
  public_subnets      = var.vpc_private_subnets

  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets    = var.vpc_db_subnets

  enable_nat_gateway = true
  single_nat_gateway  = true

  enable_dns_hostnames = true

  private_subnet_tags = {
    Name = "Private-Subnet"
  }
  public_subnet_tags = {
    Name = "Public-Subnet"
  }
  database_subnet_tags = {
    Name = "DB-Subnet"
  }
  vpc_tags = {
    Name = "VPC-Demo-1"
  }
  tags = {
    Owner = "Akshay"
    Environment = "dev"
  }
}