# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
module "networking" {
  source       = "./networking"
  region       = var.region
  project_name = var.project_name
}

module "ec2_jenkins" {
  source                   = "./instances/ec2_jenkins"
  region                   = var.region
  project_name             = var.project_name
  netmod_my_vpc_id = module.networking.my_vpc_id
  netmod_jenkins_sg_id     = module.networking.jenkins_sg_id
  netmod_jenkins_sub_id    = module.networking.jenkins_sub_id
}

module "eks_self_managed_cluster" {
  source       = "./eks"
  region       = var.region
  project_name = var.project_name

  ###############################################
  # BEGINS: EKS NAT & Subnet Setup Variables
  # 1-networking_subnets.tf, 2-networking_nat.tf, 3-networking_route_tables.tf
  ###############################################
  # Prerquisites: You need to have already deployed a module that provides you a VPC ID and Internet Gateway ID
  target_vpc_id = module.networking.my_vpc_id
  target_igw_id = module.networking.igw_id

  azs = ["${var.region}a", "${var.region}b"]

  # Define to subnet IP ranges (at least 4)
  subnets_eks_private = ["10.1.32.0/19", "10.1.64.0/19"]
  subnets_eks_public  = ["10.1.96.0/19", "10.1.128.0/19"]

  tags_subnets_eks_private = {
    "kubernetes.io/role/internal-elb"      = 1
    "kubernetes.io/cluster/my-eks" = "owned"
  }

  tags_subnets_eks_public = {
    "kubernetes.io/role/internal-elb"      = 1
    "kubernetes.io/cluster/my-eks" = "owned"
  }
  ###############################################
  # ENDS: EKS NAT & Subnet Setup Variables
  ###############################################

  ###############################################
  # BEGINS: EKS Cluster Variables
  ###############################################
  cluster_name = "${var.project_name}-eks-cluster"
  ###############################################
  # ENDS: EKS Cluster Variables
  ###############################################

  ###############################################
  # BEGINS: OpenID Provider
  ###############################################
  enable_irsa = true
  ###############################################
  # ENDS: OpenID Provider
  ###############################################
}