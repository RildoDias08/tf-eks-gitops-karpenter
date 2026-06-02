data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "tf-eks-gitops-karpenter-s3"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {}

data "aws_eks_node_group" "ng_name" {
  node_group_name = aws_eks_node_group.this.node_group_name
  cluster_name    = aws_eks_cluster.this.name
}

