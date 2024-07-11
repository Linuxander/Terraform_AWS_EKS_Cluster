resource "aws_subnet" "eks_private" {
  count             = length(var.subnets_eks_private)
  vpc_id            = var.target_vpc_id
  cidr_block        = var.subnets_eks_private[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    { Name = "${var.project_name}-private-eks-${var.azs[count.index]}" },
    var.tags_subnets_eks_private
  )
}


resource "aws_subnet" "eks_public" {
  count                   = length(var.subnets_eks_public)
  vpc_id                  = var.target_vpc_id
  cidr_block              = var.subnets_eks_public[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "${var.project_name}-public-eks-${var.azs[count.index]}" },
    var.tags_subnets_eks_public
  )
}