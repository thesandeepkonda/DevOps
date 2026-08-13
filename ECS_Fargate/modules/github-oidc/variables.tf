# ============================================================
# Project
# ============================================================

variable "project_name" {
  description = "Project name"
  type        = string
}


# ============================================================
# Environment
# ============================================================

variable "environment" {
  description = "Deployment environment"
  type        = string
}


# ============================================================
# GitHub
# ============================================================

variable "github_repository" {
  description = "GitHub repository in owner/repository format"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch allowed to deploy"
  type        = string
  default     = "main"
}


# ============================================================
# ECR
# ============================================================

variable "ecr_repository_arn" {
  description = "ECR repository ARN"
  type        = string
}


# ============================================================
# ECS
# ============================================================

variable "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  type        = string
}

variable "ecs_service_arn" {
  description = "ECS service ARN"
  type        = string
}


# ============================================================
# ECS IAM Roles
# ============================================================

variable "ecs_task_execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ECS application task role ARN"
  type        = string
}