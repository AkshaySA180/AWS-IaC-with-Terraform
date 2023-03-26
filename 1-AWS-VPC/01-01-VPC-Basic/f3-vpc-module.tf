module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "VPC-Demo1"
  cidr = "10.0.0.0/16"

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

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