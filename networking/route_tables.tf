resource "aws_route_table" "my_jenkins_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "${var.project_name} - route table - jenkins"
  }
}

resource "aws_route_table_association" "jenkins_rt_sub_association" {
  subnet_id      = aws_subnet.my_jenkins_subnet.id
  route_table_id = aws_route_table.my_jenkins_rt.id
}
