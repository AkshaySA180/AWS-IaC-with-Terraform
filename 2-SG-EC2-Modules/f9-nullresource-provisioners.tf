resource "null_resource" "name" {

  # used to connect the local laptop to the EC2 instance  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    host     = aws_eip.bastion_eip.public_dns
    private_key = file("private-key/terraform-key.pem")
  }

  # File provisioner to push the .pem file to Bastion EC2 instance
  provisioner "file" {
    source = "private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  # Remote-exec is used to provide executable permission via below command
  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /tmp/terraform-key.pem"]
  }

}