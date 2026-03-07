variable "region" {}

variable "cluster_name" {}

variable "vpc_name" {}

variable "vpc_cidr" {}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "node_instance_type" {
  type = list(string)
}

variable "node_desired_size" {}
variable "node_min_size" {}
variable "node_max_size" {}


variable "cluster_role_name" {}
variable "node_role_name" {}

variable "jenkins_user_arn" {
  description = "IAM user for Jenkins"
}