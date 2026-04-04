resource "aws_s3_bucket" "remote_state" {
  bucket = "tf-eks-gitops-karpenter-s3"

  tags = {
    Name = "tf-eks-gitops-karpenter-s3"
  }
  
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}