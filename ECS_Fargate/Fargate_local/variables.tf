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

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

# ============================================================
# VPC
# ============================================================
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used by the VPC"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = true
}

# ============================================================
# ALB & Health Check
# ============================================================
variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the application container"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "Health check path for ALB"
  type        = string
  default     = "/actuator/health"
}

# ============================================================
# ECS Fargate Task Configuration
# ============================================================
variable "task_cpu" {
  description = "CPU allocated to the ECS task"
  type        = number
}

variable "task_memory" {
  description = "Memory allocated to the ECS task"
  type        = number
}

variable "desired_count" {
  description = "Desired number of ECS tasks running"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity for auto-scaling"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for auto-scaling"
  type        = number
}

# ============================================================
# Container & Environment variables
# ============================================================
variable "container_image" {
  description = "Docker image for the application container"
  type        = string
}

variable "image_tags" {
  description = "Dynamic image tags passed from GitHub Actions"
  type        = map(string)
  default     = {}
}

variable "environment_variables" {
  description = "Environment variables for the ECS task"
  type        = map(string)
  default     = {}
}

# ============================================================
# GitHub Actions OIDC
# ============================================================
variable "github_repository" {
  description = "GitHub repository for OIDC setup"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch for OIDC setup"
  type        = string
  default     = "main"
}