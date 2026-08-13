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
# ECR
# ============================================================

variable "repository_name" {
  description = "ECR repository name"
  type        = string
}


variable "image_tag_mutability" {
  description = "ECR image tag mutability"
  type        = string

  default = "MUTABLE"

  validation {
    condition = contains(
      ["MUTABLE", "IMMUTABLE"],
      var.image_tag_mutability
    )

    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}


variable "scan_on_push" {
  description = "Enable image vulnerability scanning when images are pushed"
  type        = bool
  default     = true
}