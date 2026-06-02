resource "aws_iam_role" "eks_karpenter_controller" {
  name = "${local.project_name}-eks-karpenter-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        }
        Condition = {
          StringEquals = {
            "${replace(local.oidc_endpoint, "https://", "")}:sub" = "system:serviceaccount:karpenter:karpenter"
            "${replace(local.oidc_endpoint, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}