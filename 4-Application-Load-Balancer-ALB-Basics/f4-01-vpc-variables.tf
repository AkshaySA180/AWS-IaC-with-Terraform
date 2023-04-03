variable "vpc_name" {
  default = "VPC-Demo"
  type = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type = string
}

variable "vpc_az" {
  default = ["us-east-1a", "us-east-1b"]
  type = list(string)
}

variable "vpc_public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  type = list(string)
}

variable "vpc_private_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
  type = list(string)
}

variable "vpc_db_subnets" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
  type = list(string)
}