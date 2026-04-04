resource "aws_subnet" "private" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.each.value.cidr
  availability_zone       = var.each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-${each.key}"
  }
  
}