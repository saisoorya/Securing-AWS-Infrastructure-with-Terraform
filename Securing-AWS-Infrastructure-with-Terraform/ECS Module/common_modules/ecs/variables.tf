variable "app_name" {
  description = "The name of the application that will run on the cluster"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

variable "cpu" {
  description = "Instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
  default     = null
}

variable "memory" {
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  type        = number
  default     = null
}

variable "ulimits" {
  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  type = list(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  default = null
}

variable "environment" {
  description = "The environment variables to pass to the container. This is a list of maps"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "task_secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  description = "The secrets to pass to the container. This is a list of maps"
  default     = null
}

variable "ami_architecture" {
  default = "x86_64"
}

variable "launch_type" {
  description = "The ECS cluster launch type."
  default     = "EC2"
}

variable "assign_public_ip" {
  description = "Whether to assign public IP"
  default     = "false"
}

variable "key_name" {
  default     = null
}

variable "security_groups" {
  description = "security group for non ec2 type"
  default     = []
}

variable "deployment_maximum_percent" {
  description = "Upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  default     = 100
}

variable "ec2_instance_count_max" {
  description = "The maximum number of ec2 instances (used to autoscaling)"
  type        = number
  default     = null
}

variable "ec2_instance_count_min" {
  description = "The minimum number of ec2 instances (used for autoscaling)"
  type        = number
  default     = null
}

variable "on_demand_percentage_above_base_capacity" {
  default = 100
}

variable "spot_allocation_strategy" {
  default = "lowest-price"
}

variable "spot_instance_pools" {
  default = 1
}

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro"]
}

variable "max_task_number" {
  description = "Maximum task number"
  default     = 10
}

variable "min_task_number" {
  description = "Minimum task number"
  default     = 1
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION"
  type        = any
  default     = "TASK_DEFINITION"
}

variable "ecs_task_execution_role_arn" {
  description = "The ecs task execution arn"
  type        = string
  default     = null
}

variable "ecs_task_role_arn" {
  description = "The ecs task role arn"
  default     = null
}

variable "ec2_instance_profile_name" {
  description = "The role name to include in the IAM instance profile for ASG launch configuration."
  default     = null
  type        = string
}

variable "common_tags" {
  description = "A object map of tags to be added to this modules resources."
  type = object({
    Owner     = string
    Team      = string
  })
}

data "aws_vpc" "selected" {
  tags = {
    Tier = "public"
  }
}

data "aws_subnet_ids" "tasks" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = "public"
  }
}