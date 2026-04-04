resource "aws_ecr_repository" "this" {

  count = length(var.ecr_repo)
  name = var.ecr_repo[count.index]
  
  image_tag_mutability = "MUTABLE"
}