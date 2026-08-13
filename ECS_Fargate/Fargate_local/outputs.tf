# ============================================================
# VPC
# ============================================================

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}


# ============================================================
# Subnets
# ============================================================

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}


# ============================================================
# Route Tables
# ============================================================

output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "Private route table ID"
  value = (
    var.enable_nat_gateway
    ? aws_route_table.private[0].id
    : null
  )
}


# ============================================================
# NAT Gateway
# ============================================================

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value = (
    var.enable_nat_gateway
    ? aws_nat_gateway.this[0].id
    : null
  )
}

# ============================================================
# Security Groups
# ============================================================

output "alb_security_group_id" {
  description = "Security group ID for the Application Load Balancer"
  # Corrected to reference the module output
  value       = module.alb.security_group_id
}

output "ecs_security_group_id" {
  description = "Security group ID for ECS Fargate tasks"
  # Corrected to reference the module output
  value       = module.ecs.task_security_group_id
}