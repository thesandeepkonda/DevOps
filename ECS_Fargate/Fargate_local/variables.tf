# ============================================================
# General
# ============================================================

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}


# ============================================================
# VPC
# ============================================================

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}


# ============================================================
# Availability Zones
# ============================================================

variable "availability_zones" {
  description = "Availability zones used by the VPC"
  type        = list(string)
}


# ============================================================
# Public Subnets
# ============================================================

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}


# ============================================================
# Private Subnets
# ============================================================

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}


# ============================================================
# NAT Gateway
# ============================================================

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = true
}


# ============================================================
# Application Port
# ============================================================

variable "container_port" {
  description = "Port exposed by the application container"
  type        = number
  default     = 8080
}

variable "image_tags" {
  description = "Dynamic image tags passed from GitHub Actions"
  type        = map(string)
  default     = {}
}