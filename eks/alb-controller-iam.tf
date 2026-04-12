#criando policy para o alb-controller
resource "aws_iam_policy" "alb_controller_policy" {
  name = "eks-alb-policy"
  description = "Policy do alb-controller"
  policy = file("${path.module}/alb-controller-policy.json")
}

#editando trust da eks-alb-role para usar OIDC provider do EKS
data "aws_iam_policy_document" "aws_load_balancer_controller_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

#criando role para o alb-controller
resource "aws_iam_role" "aws_load_balancer_controller" {
  name = "eks-alb-role"
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_controller_assume_role.json
}

#atachando a policy do alb_controller a role
resource "aws_iam_role_policy_attachment" "alb_policy_attachment" {
  role = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.alb_controller_policy.arn
}