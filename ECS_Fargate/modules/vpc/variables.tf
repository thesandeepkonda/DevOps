# General

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}


# VPC

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}


# Availability Zones

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two availability zones are required."
  }
}


# Public Subnets

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "The number of public subnets must match the number of availability zones."
  }
}


# Private Subnets

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "The number of private subnets must match the number of availability zones."
  }
}


# NAT Gateway

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}