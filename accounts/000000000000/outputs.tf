output "module_groups_user_names" {
  value = module.iam_groups_with_users_and_policies.user_names
}

output "module_groups_group_names" {
  value = module.iam_groups_with_users_and_policies.group_names
}

output "module_groups_users_access_key" {
  value = module.iam_groups_with_users_and_policies.access_key
}

output "module_groups_users_encrypted_secret_key" {
  value = module.iam_groups_with_users_and_policies.encrypted_secret_key
}

output "module_roles_arns" {
  value = module.iam_roles.role_arns
}