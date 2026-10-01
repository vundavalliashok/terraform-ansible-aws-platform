output "ansible_host" {
  description = "Public IP used by Ansible"
  value       = module.ec2.public_ip
}

output "ansible_user" {
  description = "Default Ubuntu SSH user"
  value       = "ubuntu"
}