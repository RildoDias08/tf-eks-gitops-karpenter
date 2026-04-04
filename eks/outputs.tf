data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "tf-eks-gitops-karpenter-s3"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}