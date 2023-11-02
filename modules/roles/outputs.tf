output "role_arns" {
  value = [for role in aws_iam_role.roles : role.arn]
}