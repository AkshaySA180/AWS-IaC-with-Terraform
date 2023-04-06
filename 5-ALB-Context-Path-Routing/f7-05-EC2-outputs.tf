output "Bastion_Instance_IP" {
  value = module.Bastion_EC2.public_ip
}

output "Private_Instance_IPs_app1" {
  value = [for n in module.Private_EC2_1: n.private_ip]
}

output "Private_Instance_IPs_app2" {
  value = [for n in module.Private_EC2_2: n.private_ip]
}