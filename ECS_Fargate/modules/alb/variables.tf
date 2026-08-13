
# Project


variable "project_name" {
  description = "Project name"
  type        = string
}



# Environment


variable "environment" {
  description = "Environment name"
  type        = string
}



# VPC


variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string
}



# Public Subnets


variable "public_subnet_ids" {
  description = "Public subnet IDs for the internet-facing ALB"
  type        = list(string)
}



# Application Port


variable "container_port" {
  description = "Application container port"
  type        = number
}



# Health Check


variable "health_check_path" {
  description = "ALB health check path"
  type        = string

  default = "/actuator/health"
}



# ACM Certificate


variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}