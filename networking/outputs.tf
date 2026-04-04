output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
    value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnets" {
    value = [for subnet in aws_subnet.private_subnets : subnet.id]
}