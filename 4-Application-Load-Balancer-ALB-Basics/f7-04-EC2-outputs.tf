output "Bastion_Instance_IP" {
  value = module.Bastion_EC2.public_ip
}

output "Private_Instance_IPs" {
  value = [for n in module.Private_EC2: n.private_ip]
}