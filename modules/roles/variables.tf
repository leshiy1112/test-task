variable "roles" {
  description = "A list of IAM roles to create with assume role policies"
  type          = list(object({
    name        = string
    actions     = list(string)
    type        = string
    identifiers = list(string)
  }))
  default     = []
}

variable "roles_policies" {
  description = "List of policies form each group"
  type        = list(string)
}

variable "policy_attachments" {
  description = "List of policy attachments"
  type        = list(object({
    role        = string
    policy_name = string
  }))
}
