terraform{
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 6.38"
      }
    }
    backend "s3" {
    bucket = "tf-eks-gitops-karpenter-s3"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    
    #deprecado
    #dynamodb_table = "tf-eks-gitops-karpenter-locks"
  }
}
