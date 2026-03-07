module "eks_cluster" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    microservices_nodes = {

      desired_size = var.node_desired_size
      min_size     = var.node_min_size
      max_size     = var.node_max_size

      instance_types = var.node_instance_type

      capacity_type = "ON_DEMAND"

      iam_role_arn = var.node_role_arn
    }
  }

}