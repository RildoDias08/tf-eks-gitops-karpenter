resource "aws_vpc" "this" {
  cidr_block           = var.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
  
}