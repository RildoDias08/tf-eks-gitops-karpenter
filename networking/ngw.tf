resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.nat.id
    subnet_id = var.public_subnets[0].id

    tags = {
        Name = "${var.project_name}-ngw"
    }

    depends_on = [ aws_internet_gateway.igw ]
  
}