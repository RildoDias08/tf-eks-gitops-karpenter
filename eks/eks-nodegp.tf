resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.project_name}-eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = data.terraform_remote_state.networking.outputs.private_subnets
  instance_types = [ "t3.medium" ]
  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  depends_on = [aws_iam_role_policy_attachment.eks_node_group_AmazonEKSWorkerNodePolicy
                 ,aws_iam_role_policy_attachment.eks_node_group_AmazonEKS_CNI_Policy
                 ,aws_iam_role_policy_attachment.eks_node_group_AmazonEC2ContainerRegistryReadOnly
                 ]
}