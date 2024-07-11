resource "aws_eip" "nat_for_eks" {
  tags = {
    Name = "${var.project_name}-nat-eip-eks"
  }
}

resource "aws_nat_gateway" "nat_for_eks" {
  allocation_id = aws_eip.nat_for_eks.id
  subnet_id     = aws_subnet.eks_public[0].id # must be placed in public subnet

  tags = {
    Name = "${var.project_name}-nat-gateway-eks"
  }

  depends_on = [data.aws_internet_gateway.igw]
}

# Created this data object to use in the aws_nat_gatway depends_on
data "aws_internet_gateway" "igw" {
  internet_gateway_id = var.target_igw_id
}