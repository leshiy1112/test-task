output "group_names" {
  description = "Names of groups"
  value       = aws_iam_group.groups[*].name
}

output "user_names" {
  description = "Names of users"
  value       = aws_iam_user.users[*].name
}

output "encrypted_secret_key" {
  description = "Encrypted secret key"
  value = aws_iam_access_key.users[*].encrypted_secret
}

output "access_key" {
  description = "Access key ID"
  value = aws_iam_access_key.users[*].id
}
