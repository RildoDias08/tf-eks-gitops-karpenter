/*resource "aws_dynamodb_table" "this" {
  name         = "tf-eks-gitops-karpenter-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "tf-eks-gitops-karpenter-locks"
  }
  
}
*/