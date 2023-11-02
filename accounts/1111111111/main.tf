module "iam_roles_account_1111111111" {
  source = "../../modules/roles"
  roles = [
    {
      name   = "roleC",
      policy = "policyC",
    },
  ]

  # roles_policies = ["policyC"]
  # policy_attachments = [
  #   { role = "roleC", policy_name = "policyC" },
  # ]
}