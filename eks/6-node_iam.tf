# Create the required IAM role with an AmazonEKSCluAmazonEKSWorkerNodePolicy attached for our worker nodes
resource "aws_iam_role" "nodes" {
  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole",
      Effect : "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-policies" {
  for_each   = var.node_iam_policies
  policy_arn = each.value
  role       = aws_iam_role.nodes.name
}