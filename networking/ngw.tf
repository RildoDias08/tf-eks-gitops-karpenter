resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.nat.id
    subnet_id = values(aws_subnet.public)[1].id

    tags = {
        Name = "${var.project_name}-ngw"
    }

    depends_on = [ aws_internet_gateway.igw ]
  
}