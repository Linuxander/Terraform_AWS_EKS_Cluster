resource "aws_eks_node_group" "self-managed-private-node-group" {
  cluster_name    = var.cluster_name
  # node_group_name = "self-managed-private-node-group" # This will hard code this name for the node group... cannot be used with node_group_name_prefix variable
  node_group_name_prefix = "eks-private-node-" # Terraform will auto popoulate a suffix... This variable cannot be used with node_group_name variable
  node_role_arn   = aws_iam_role.nodes.arn  

  subnet_ids = local.node_private_subnet_ids

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]

  scaling_config { # without defining your own cluster autoscaler, AWS will use these to autoscale on your behalf
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config { # setting used during node group updates
    max_unavailable = 1
  }

  labels = { # setting used for k8s scheduler by using affinity or node selector
    role = "general"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }"

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.nodes-policies["1"], # Ref var.node_iam_policies 1 = AmazonEKSWorkerNodePolicy
    aws_iam_role_policy_attachment.nodes-policies["2"], # Ref var.node_iam_policies 2 = AmazonEKS_CNI_Policy
    aws_iam_role_policy_attachment.nodes-policies["3"]  # Ref var.node_iam_policies 3 = AmazonEC2ContainerRegistryReadOnly
  ]
}

# After this terraform file successfully completes you can update your kubectl config like this:
# aws eks update-kubeconfig --name [your cluster name] --region [region cluster deployed to]

# Then you can run the following to see the nodes that were created:
# kubectl get nodes