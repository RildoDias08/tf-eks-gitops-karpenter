resource "aws_ec2_tag" "private_subnets" {
  for_each = toset(data.terraform_remote_state.networking.outputs.private_subnets)
  resource_id = each.value
  key         = "Karpenter.sh/discovery"
  value       = aws_eks_cluster.this.id
}

resource "aws_ec2_tag" "security_group" {
  resource_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  key         = "Karpenter.sh/discovery"
  value       = aws_eks_cluster.this.id
}