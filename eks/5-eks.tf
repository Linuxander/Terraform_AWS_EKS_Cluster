# Create the required IAM role with an AmazonEKSClusterPolicy attached for our EKS cluster
resource "aws_iam_role" "eks_role" {
  name = "${var.project_name}-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
  #version = var.eks_version
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids              = local.node_public_subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy]
}