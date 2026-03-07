############################
# VPC
############################

module "vpc" {

  source = "./modules/vpc"

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

############################
# IAM ROLES
############################

module "iam" {

  source = "./modules/iam"

  cluster_role_name = "${var.cluster_name}-cluster-role"
  node_role_name    = "${var.cluster_name}-node-role"
}

############################
# EKS CLUSTER
############################

module "eks" {

  source = "./modules/eks"

  cluster_name = var.cluster_name

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  node_instance_type = var.node_instance_type

  node_desired_size = var.node_desired_size
  node_min_size     = var.node_min_size
  node_max_size     = var.node_max_size
}

############################
# KUBERNETES PROVIDER
############################

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

############################
# AWS AUTH (JENKINS ACCESS)
############################

module "aws_auth" {

  source = "./modules/aws-auth"

  cluster_name     = module.eks.cluster_name
  node_role_arn    = module.iam.node_role_arn
  jenkins_user_arn = var.jenkins_user_arn

  depends_on = [
    module.eks
  ]
}