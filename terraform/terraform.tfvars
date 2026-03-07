region = "ap-south-1"

cluster_name = "microservices-eks"

vpc_name = "microservices-vpc"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

node_instance_type = ["m7i-flex.large"]

node_desired_size = 2
node_min_size     = 1
node_max_size     = 3


cluster_role_name = "microservices-cluster-role"
node_role_name    = "microservices-node-role"

jenkins_user_arn = "arn:aws:iam::900253478849:user/jenkins"