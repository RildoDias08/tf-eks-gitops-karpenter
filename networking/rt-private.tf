resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw.id
    }

    tags = {
      name = "${var.project_name}-private-rt"
    }
}

resource "aws_route_table_association" "private" {
    for_each = var.private_subnets
    subnet_id = each.value.id
    route_table_id = aws_route_table.private.id
}

