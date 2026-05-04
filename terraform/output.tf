output "instance_public_ip" {
  value = module.ec2_instance.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${module.ec2_instance.public_ip}"
}