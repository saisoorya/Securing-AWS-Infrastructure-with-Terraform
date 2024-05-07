output "name" {
  description = "The name of the role. `null` if `role_enabled` is set to `false`"
  value       = var.role_enabled ? join("", aws_iam_role.assume_role.*.name) : null
}

output "arn" {
  description = "The ARN of the role. `null` if `role_enabled` is set to `false`"
  value       = var.role_enabled ? join("", aws_iam_role.assume_role.*.arn) : null
}

output "id" {
  description = "The the id of the IAM role. `null` if `role_enabled` is set to `false`"
  value       = var.role_enabled ? join("", aws_iam_role.assume_role.*.id) : null
}

output "unique_id" {
  description = "The stable and unique string identifying the role. `null` if `role_enabled` is set to `false`"
  value       = var.role_enabled ? join("", aws_iam_role.assume_role.*.unique_id) : null
}
