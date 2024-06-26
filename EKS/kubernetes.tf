# Provider configuration for AWS
provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# Provider configuration for Kubernetes
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Data block to retrieve the EKS cluster authentication token
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Module to create the EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.subnet_ids
  vpc_id          = var.vpc_id
  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

# Variable declarations
variable "region" {
  default = "ap-south-1"
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "cluster_version" {
  default = "1.21"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
