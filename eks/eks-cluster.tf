resource "aws_eks_cluster" "this" {
  name     = "${local.project_name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  enabled_cluster_log_types = [ "api", "audit", "authenticator", "controllerManager", "scheduler" ]

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  vpc_config {
    subnet_ids = data.terraform_remote_state.networking.outputs.private_subnets
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
  
}