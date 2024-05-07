variable "common_tags" {
  description = "Description of resources."
  type = object({
    Owner        = string
    Team         = string
  })
}

variable "app_name" {
  description = "The app name of the ECS cluster"
  type        = string
}

