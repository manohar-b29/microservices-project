variable "cluster_name" {}

variable "vpc_id" {}

variable "private_subnets" {
  type = list(string)
}

variable "cluster_role_arn" {}
variable "node_role_arn" {}

variable "node_instance_type" {
  type = list(string)
}

variable "node_desired_size" {}
variable "node_min_size" {}
variable "node_max_size" {}