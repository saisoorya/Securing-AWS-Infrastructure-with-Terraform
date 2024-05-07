variable "attachable_policy_arns" {
  description = "The ARNs of the policies you want to attach to this role"
  type        = list(string)
}

variable "principals" {
  description = "Resources (or resource patterns) to which `AssumeRole` action applies"

  type = list(object({
    type        = string
    identifiers = list(string)
  }))
}

variable "role_enabled" {
  description = "Enable / disable creation of a role"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "The name of the role"
  type        = string
}

variable "role_path" {
  description = "The path to the role"
  type        = string
  default     = "/"
}

variable "role_tags" {
  description = "Key-value mapping of tags for the IAM role"

  type = object({
    Owner = string
    Team  = string
  })
}
