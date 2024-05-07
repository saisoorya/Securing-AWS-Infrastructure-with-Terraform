resource "aws_ecs_cluster" "main" {
  name               = "${var.app_name}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = merge(
    var.common_tags,
    {
      Name = "${var.app_name}-cluster",
    }
  )
}

resource "aws_ecs_service" "main" {
  name                               = "${var.app_name}-service"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.app.arn
  desired_count                      = var.app_count
  launch_type                        = var.launch_type
  propagate_tags                     = var.propagate_tags
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent

  tags = merge(
    var.common_tags,
    {
      Name = "${var.app_name}-service"
    }
  )

  lifecycle {
    ignore_changes = [desired_count]
  }
}

module "container-definition" {
  source       = "./container-definition"
  app_image    = var.app_image
  app_name     = var.app_name
  cpu          = var.cpu
  memory       = var.memory
  ulimits      = var.ulimits
  environment  = var.environment
  task_secrets = var.task_secrets

}

resource "aws_ecs_task_definition" "app" {
  family                   = var.app_name
  network_mode             = "host"
  requires_compatibilities = [var.launch_type]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  tags = merge(
    var.common_tags,
    {
      Name = "${var.app_name}-task"
    }
  )

  lifecycle {
    create_before_destroy = true
  }

  container_definitions = module.container-definition.json

}
