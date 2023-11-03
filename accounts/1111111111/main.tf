module "iam_roles_account_1111111111" {
  source = "../../modules/roles"
  roles = [
    {
      name = "roleC",
      actions = ["sts:AssumeRole"],
      type = "Service",
      identifiers = ["s3.amazonaws.com"],
    },
  ]

  roles_policies = ["policyC"]
  policy_attachments = [
    { role = "roleC", policy_name = "policyC" },
  ]
}