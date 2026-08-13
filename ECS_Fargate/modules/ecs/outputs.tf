# ============================================================
# ECS Cluster
# ============================================================

output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.this.id
}

output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = aws_ecs_cluster.this.arn
}


# ============================================================
# ECS Service
# ============================================================

output "service_id" {
  description = "ECS service ID"
  value       = aws_ecs_service.this.id
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "ECS service ARN"
  value       = aws_ecs_service.this.id
}


# ============================================================
# Task Definition
# ============================================================

output "task_definition_arn" {
  description = "ECS task definition ARN"
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "ECS task definition family"
  value       = aws_ecs_task_definition.this.family
}


# ============================================================
# ECS Task Execution Role
# ============================================================

output "task_execution_role_arn" {
  description = "ECS task execution role ARN"
  value       = aws_iam_role.task_execution.arn
}


# ============================================================
# ECS Application Task Role
# ============================================================

output "task_role_arn" {
  description = "ECS application task role ARN"
  value       = aws_iam_role.task.arn
}


# ============================================================
# ECS Task Security Group
# ============================================================

output "task_security_group_id" {
  description = "Security group ID for ECS Fargate tasks"
  value       = aws_security_group.task.id
}


# ============================================================
# CloudWatch
# ============================================================

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.this.name
}