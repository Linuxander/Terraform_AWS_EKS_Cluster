# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Vairable for project name to label tags properly"
  type        = string
}


###############################################
# BEGINS: EKS NAT & Subnet Setup Variables
# 1-networking_subnets.tf, 2-networking_nat.tf, 3-networking_route_tables.tf
###############################################
variable "target_vpc_id" {
  description = "The VPC ID deploying this EKS cluster to."
  type        = string
}

variable "target_igw_id" {
  description = "The target internet gatway to deploy the NAT into"
  type        = string
}

variable "azs" { # Example: azs = ["${var.region}a", "${var.region}b"]
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "subnets_eks_private" {
  # Example: subnets_eks_private = ["10.1.32.0/19", "10.1.64.0/19"]
  description = "CIDR ranges for private subnets"
  type        = list(string)
}

variable "subnets_eks_public" {
  # Example: subnets_eks_public  = ["10.1.96.0/19", "10.1.128.0/19"]
  description = "CIDR ranges for public subnets"
  type        = list(string)
}

variable "tags_subnets_eks_private" {
  # Example:
  # tags_subnets_eks_private = {
  #   "kubernetes.io/role/internal-elb"      = 1
  #   "kubernetes.io/cluster/my-eks" = "owned"
  # }
  description = "Private subnet tags"
  type        = map(any)
}

variable "tags_subnets_eks_public" {
  # Example:
  # tags_subnets_eks_public = {
  #   "kubernetes.io/role/internal-elb"      = 1
  #   "kubernetes.io/cluster/my-eks" = "owned"
  # }
  description = "Public subnet tags"
  type        = map(any)
}
###############################################
# ENDS: EKS NAT & Subnet Setup Variables
###############################################

###############################################
# BEGINS: EKS Cluster Variables
###############################################
variable "cluster_name" {
  description = "The name of your cluster"
  default     = "my-eks-cluster"
}

variable "node_iam_policies" {
  description = "List of IAM policies to attach to EKS-managed nodes"
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}
###############################################
# ENDS: EKS Cluster Variables
###############################################

###############################################
# BEGINS: OpenID Provider Variables
###############################################
variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS"
  type        = bool
  default     = false
}
###############################################
# BEGINS: OpenID Provider Variables
###############################################


# variable "node_groups" {
#   description = "EKS node groups"
#   type        = map(any)
# }

# variable "enable_irsa" {
#   description = "Determines whether to create an OpenID Connect Provider for EKS"
#   type        = bool
#   default     = false
# }

# variable "eks_version" {
#   description = "Desired Kubernetes master version"
#   type        = string
# }




# # variable "netmod_my_vpc_id" {
# #   description = "Network module my_vpc_id reference"
# #   type        = string
# # }

# # variable "netmod_sub_eks_public_id" {
# #   description = "Network module netmod_sub_eks_public_id reference"
# #   type        = list(string)
# # }

# # variable "netmod_sub_eks_private_id" {
# #   description = "Network module netmod_sub_eks_private_id reference"
# #   type        = list(string)
# # }

# # variable "netmod_sub_eks_intra_id" {
# #   description = "Network module netmod_sub_eks_intra_id reference"
# #   type        = list(string)
# # }

# # variable "netmod_sub_eks_public_cidr" {
# #   description = "Network module netmod_sub_eks_public_id reference"
# #   type        = string
# # }

# # variable "netmod_sub_eks_private_cidr" {
# #   description = "Network module netmod_sub_eks_private_id reference"
# #   type        = string
# # }

# # variable "netmod_sub_eks_intra_cidr" {
# #   description = "Network module netmod_sub_eks_intra_id reference"
# #   type        = string
# # }