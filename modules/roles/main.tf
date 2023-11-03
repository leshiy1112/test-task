data "aws_iam_policy_document" "assume_role_policy" {
 for_each = { for i in var.roles : i.name => i }

 statement {
   actions   = each.value.actions
   principals {
     type        = each.value.type
     identifiers = each.value.identifiers
   }
 }
}

# resource "aws_iam_role" "roles" {
#  for_each = { for i in var.roles : i.name => i }

#  name = each.value.name
#  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[each.key].json
# }
resource "aws_iam_role" "roles" {
 for_each = { for i in var.roles : i.name => i }

 name = each.value.name
 assume_role_policy = data.aws_iam_policy_document.assume_role_policy[each.key].json
 depends_on = [data.aws_iam_policy_document.assume_role_policy]
}

resource "aws_iam_policy" "roles_policies" {
  count       = length(var.roles_policies)
  name        = var.roles_policies[count.index]
  policy      = templatefile("${path.module}/policies/${var.roles_policies[count.index]}.json", {})
}

data "aws_iam_policy" "roles_policies" {
  for_each = toset([for pa in var.policy_attachments : pa.policy_name])
  name    = each.value
  depends_on = [aws_iam_policy.roles_policies]
}

resource "aws_iam_policy_attachment" "roles_attachment" {
  count       = length(var.policy_attachments)
  name        = "attachment-${var.policy_attachments[count.index].role}"
  policy_arn  = data.aws_iam_policy.roles_policies[var.policy_attachments[count.index].policy_name].arn
  roles       = [var.policy_attachments[count.index].role]
  depends_on  = [data.aws_iam_policy.roles_policies, aws_iam_role.roles]
}
