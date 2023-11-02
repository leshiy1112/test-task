variable "groups" {
  description = "List of group names"
  type        = list(string)
}

variable "users" {
  description = "List of user names and assignments to group"
  type        = list(object({
    name    = string
    group   = string
    is_cli  = bool
  }))
}

variable "group_policies" {
  description = "List of policies form each group"
  type        = list(string)
}

#variable "group_policy_assignments" {
#  description = "Assignments groups to policies"
#  type        = list(map(string))
#}
variable "group_policy_assignments" {
  description = "Assignments groups to policies"
  type        = list(object({
    group    = string
    policy   = string
  }))
}
