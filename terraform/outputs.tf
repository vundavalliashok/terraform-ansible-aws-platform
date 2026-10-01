output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = module.ec2.public_ip
}

output "private_ip" {
  description = "EC2 private IP"
  value       = module.ec2.private_ip
}

output "security_group_id" {
  description = "EC2 security group ID"
  value       = module.security.security_group_id
}