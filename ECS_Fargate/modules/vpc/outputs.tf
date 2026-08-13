# VPC ID

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}


# VPC CIDR

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}


# Public Subnets

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}


# Private Subnets

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}


# Public Route Table

output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}


# Private Route Table

output "private_route_table_id" {
  description = "Private route table ID"
  value = (
    var.enable_nat_gateway
    ? aws_route_table.private[0].id
    : null
  )
}


# NAT Gateway

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value = (
    var.enable_nat_gateway
    ? aws_nat_gateway.this[0].id
    : null
  )
}