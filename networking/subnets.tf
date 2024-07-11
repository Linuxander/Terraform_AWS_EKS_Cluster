resource "aws_subnet" "my_jenkins_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_jenkins
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name} - subnet - jenkins"
  }
}
