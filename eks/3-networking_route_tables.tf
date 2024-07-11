

resource "aws_route_table" "eks_private_rt" {
  vpc_id = var.target_vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_for_eks.id
  }

  tags = {
    Name = "${var.project_name} - route table - private - eks"
  }
}

resource "aws_route_table_association" "eks_private_assosiation" {
  count = length(var.subnets_eks_private)

  subnet_id      = aws_subnet.eks_private[count.index].id
  route_table_id = aws_route_table.eks_private_rt.id
}

resource "aws_route_table" "eks_public_rt" {
  vpc_id = var.target_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.target_igw_id
  }

  tags = {
    Name = "${var.project_name} - route table - public - eks"
  }
}

resource "aws_route_table_association" "eks_public_assosiation" {
  count = length(var.subnets_eks_public)

  subnet_id      = aws_subnet.eks_public[count.index].id
  route_table_id = aws_route_table.eks_public_rt.id
}