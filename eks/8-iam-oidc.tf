# OpenID Connect Provider allows you to associate IAM roles with Kubernetes service accounts.
# You will need this if your k8s application service accounts need to access AWS resources
# Documentation: https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html

data "tls_certificate" "tls_cert" { # This gets the cluster certificate
  count = var.enable_irsa ? 1 : 0

  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "iam_openid_provider" {
  count = var.enable_irsa ? 1 : 0

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.tls_cert[0].certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}