module "ecs_task_role" {
  source = "./iam-assume-role"
  
  attachable_policy_arns          = []

  principals = [
    {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  ]

  role_name = "${var.app_name}-ecsTaskRole"
  role_tags = merge(var.common_tags, { Component = "ECS Tasks Role" })
}

module "ecs_task_execution_role" {
  source = "./iam-assume-role"

  attachable_policy_arns          = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]

  principals = [
    {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  ]

  role_name = "${var.app_name}-ecsTaskExecutionRole"
  role_tags = merge(var.common_tags, { Component = "ECS Task Execution Role" })
}

module "ecs_ec2_instance_profile_role" {
  source = "./iam-assume-role"

  attachable_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole",
    "arn:aws:iam::269471155370:policy/ECR-Custom-Policy"
  ]

  principals = [
    {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  ]

  role_name = "${var.app_name}-ecsEc2InstanceRole"
  role_tags = merge(var.common_tags, { Component = "ECS EC2 Instance Role" })
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name  = "${var.app_name}-ecsEc2InstanceProfile"
  path  = "/"
  role  = module.ecs_ec2_instance_profile_role.name
}
