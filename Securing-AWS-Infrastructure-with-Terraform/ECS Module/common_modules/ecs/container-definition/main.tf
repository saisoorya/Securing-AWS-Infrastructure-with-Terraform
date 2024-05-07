locals {
  env_vars             = var.environment != null ? var.environment : []
  env_vars_keys        = [for m in local.env_vars : lookup(m, "name")]
  env_vars_values      = [for m in local.env_vars : lookup(m, "value")]
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]

  null_value = var.environment == null ? var.environment : null

  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : local.null_value

  container_definition = {
    name              = var.app_name
    image             = var.app_image
    command           = var.command
    ulimits           = var.ulimits
    memory            = var.memory
    cpu               = var.cpu
    environment       = local.final_environment_vars
    secrets           = var.task_secrets
  }

  json_map = jsonencode(local.container_definition)
}
