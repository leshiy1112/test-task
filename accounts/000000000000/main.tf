module "iam_groups_with_users_and_policies" {
  source         = "../../modules/groups"
  groups         = ["Group1", "Group2"]
  group_policies = ["Cli_Policy", "Full_Policy"]

  group_policy_assignments = [
    { group = "Group1", policy = "Cli_Policy" },
    { group = "Group2", policy = "Full_Policy" },
  ]
  users = [
    { name = "engine", group = "Group1", is_cli = true },
    { name = "ci", group = "Group1", is_cli = true },
    { name = "denys.platon", group = "Group2", is_cli = false },
    { name = "ivan.petrenko", group = "Group2", is_cli = false },
  ]
}

module "iam_roles" {
  source = "../../modules/roles"
  roles = [
    {
      name = "roleA",
      actions  = ["sts:AssumeRole"],
      type = "Service",
      identifiers = ["ec2.amazonaws.com"],
      resources = ["*"]
    },
    {
      name = "roleB",
      actions  = ["sts:AssumeRole"],
      type = "Service",
      identifiers = ["s3.amazonaws.com"],
    },
  ]
  roles_policies = ["policyA", "policyB"]
  policy_attachments = [
    { role = "roleB", policy_name = "policyB" },
    { role = "roleA", policy_name = "policyA" },
  ]
}
