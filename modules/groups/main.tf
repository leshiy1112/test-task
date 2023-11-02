resource "aws_iam_group" "groups" {
  count = length(var.groups)
  name  = var.groups[count.index]
}

resource "aws_iam_user" "users" {
  count = length(var.users)
  name  = var.users[count.index].name
}

resource "aws_iam_user_login_profile" "users" {
  for_each = { for k, v in var.users : k => v if v.is_cli }
  user     = each.value.name
  password_reset_required = true
  pgp_key  = file("${path.module}/keys/publicbase64.key")
}

resource "aws_iam_access_key" "users" {
  count = length(var.users)
  user  = var.users[count.index].name
  pgp_key = file("${path.module}/keys/publicbase64.key")
}

resource "aws_iam_group_membership" "membership" {
  count = length(var.users)
  name  = aws_iam_user.users[count.index].name
  users = [aws_iam_user.users[count.index].name]
  group = element(var.users, count.index).group
}

resource "aws_iam_policy" "group_policies" {
  count       = length(var.group_policies)
  name        = var.group_policies[count.index]
  policy      = templatefile("${path.module}/policies/${var.group_policies[count.index]}.json", {})
}

data "aws_iam_policy" "group_policies" {
  for_each = toset([for pa in var.group_policy_assignments : pa.policy])
  name    = each.value
  depends_on = [aws_iam_policy.group_policies]
}

resource "aws_iam_policy_attachment" "group_attachment" {
  count       = length(var.group_policy_assignments)
  name        = "attachment-${var.group_policy_assignments[count.index].group}"
  policy_arn  = data.aws_iam_policy.group_policies[var.group_policy_assignments[count.index].policy].arn
  users       = [var.group_policy_assignments[count.index].group]
}
