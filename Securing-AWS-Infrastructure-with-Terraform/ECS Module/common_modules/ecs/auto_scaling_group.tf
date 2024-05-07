resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  name                = "${var.app_name}-ecs-autoscaling-group"
  max_size            = var.ec2_instance_count_max
  min_size            = var.ec2_instance_count_min
  vpc_zone_identifier = data.aws_subnet_ids.tasks.ids
  health_check_type   = "EC2"
  mixed_instances_policy {
    instances_distribution {
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.spot_allocation_strategy
      spot_instance_pools                      = var.spot_instance_pools
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ecs_launch_template.id
        version            = "$Latest"

      }

      dynamic "override" {
        for_each = var.instance_types
        content {
          instance_type = override.value
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  dynamic "tag" {
    for_each = merge(
      var.common_tags,
      {
        Name = "${var.app_name}-ecs-asg"
      }
    )
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

