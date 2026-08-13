# ============================================================
# General
# ============================================================

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}


# ============================================================
# GitHub Actions
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
  description = "ARN of the ECR repository"
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