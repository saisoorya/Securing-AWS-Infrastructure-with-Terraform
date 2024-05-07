resource "aws_launch_template" "ecs_launch_template" {
  name_prefix             = "${var.app_name}-template"
  disable_api_termination = false
  instance_type           = var.instance_types[0]
  image_id                = data.aws_ami.latest_ecs_optimized.id
  key_name                = var.key_name
  update_default_version  = true
  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }
  network_interfaces {
    associate_public_ip_address = var.assign_public_ip
    security_groups             = [aws_security_group.cy7900_sg.id]
    delete_on_termination       = true
  }
  
  lifecycle {
    create_before_destroy = true
  }
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      var.common_tags,
      {
        Name = "${var.app_name}-volume",
      }
    )
  }
  user_data = data.template_cloudinit_config.user_data.rendered
}

data "template_cloudinit_config" "user_data" {

  base64_encode = true
  gzip          = false
  part {
    content_type = "text/x-shellscript"
    content      = <<EOT
#!/bin/bash
echo ECS_CLUSTER=${var.app_name}-cluster >> /etc/ecs/ecs.config
echo ECS_ENABLE_CONTAINER_METADATA=true >> /etc/ecs/ecs.config
echo ECS_ENABLE_SPOT_INSTANCE_DRAINING=true >> /etc/ecs/ecs.config
EOT
  }
}

data "aws_ami" "latest_ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["${var.ami_architecture}"]
  }
}
