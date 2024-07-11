locals {
  node_public_subnet_ids  = aws_subnet.eks_public.*.id
  node_private_subnet_ids = aws_subnet.eks_private.*.id
}