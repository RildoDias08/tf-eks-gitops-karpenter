locals {
  project_name = data.terraform_remote_state.networking.outputs.project_name
}

locals {
  oidc_endpoint = aws_eks_cluster.this.identity[0].oidc[0].issuer
}