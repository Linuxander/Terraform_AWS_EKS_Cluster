output "my_vpc_id" {
  description = "The ID of the my_vpc"
  value       = aws_vpc.my_vpc.id
}

output "jenkins_sg_id" {
  description = "The ID of the my_jenkins_security_group"
  value       = aws_security_group.my_jenkins_securitygroup.id
}

output "jenkins_sub_id" {
  description = "The ID of the my_jenkins_subnet"
  value       = aws_subnet.my_jenkins_subnet.id
}

output "igw_id" {
  description = "The ID of the internet gatway"
  value       = aws_internet_gateway.my_igw.id
}

output "igw_resource_object" {
  description = "The ID of the internet gatway"
  value       = aws_internet_gateway.my_igw
}