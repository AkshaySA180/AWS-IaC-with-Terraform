# Bastion host or Public subnet SG outputs 
output "Bastion_SG_id" {
  description = "The ID of the Bastion_SG group"
  value       = module.Bastion_SG.security_group_id
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.Bastion_SG.security_group_vpc_id
}

output "security_group_name" {
  description = "The name of the Bastion_SG security group"
  value       = module.Bastion_SG.security_group_name
}

# Private SG outputs
output "Private_SG_id" {
  description = "The ID of the Private_SG group"
  value       = module.Bastion_SG.security_group_id
}

output "Private_SG_vpc_id" {
  description = "The VPC ID"
  value       = module.Private_SG.security_group_vpc_id
}

output "Private_SG_name" {
  description = "The name of the Private_SG security group"
  value       = module.Private_SG.security_group_name
}

