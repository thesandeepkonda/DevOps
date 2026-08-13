# ============================================================
# GitHub Actions Role ARN
# ============================================================

output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions"

  value = aws_iam_role.github_actions.arn
}


# ============================================================
# GitHub Actions Role Name
# ============================================================

output "github_actions_role_name" {
  description = "IAM role name used by GitHub Actions"

  value = aws_iam_role.github_actions.name
}


# ============================================================
# GitHub OIDC Provider ARN
# ============================================================

output "github_oidc_provider_arn" {
  description = "GitHub Actions OIDC provider ARN"

  value = aws_iam_openid_connect_provider.github.arn
}