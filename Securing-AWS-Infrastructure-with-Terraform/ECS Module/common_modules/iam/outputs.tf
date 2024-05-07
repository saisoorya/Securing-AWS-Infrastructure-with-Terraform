output "ecs_task_role_name" {
  description = "The name of IAM role that allows ECS container task to make calls to other AWS services"
  value       = module.ecs_task_role.name
}

output "ecs_task_role_arn" {
  description = "The ARN of IAM role that allows ECS container task to make calls to other AWS services"
  value       = module.ecs_task_role.arn
}

output "ecs_task_role_id" {
  description = "The ARN of IAM role that allows ECS container task to make calls to other AWS services"
  value       = module.ecs_task_role.id
}

output "ecs_task_role_unique_id" {
  description = "The stable and unique string of IAM role that allows ECS container task to make calls to other AWS services"
  value       = module.ecs_task_role.unique_id
}

output "ecs_task_execution_role_name" {
  description = "The name of the role that ECS container agent and the Docker daemon can assume"
  value       = module.ecs_task_execution_role.name
}

output "ecs_task_execution_role_arn" {
  description = "The ARN of the role that ECS container agent and the Docker daemon can assume"
  value       = module.ecs_task_execution_role.arn
}

output "ecs_task_execution_role_id" {
  description = "The ID of IAM role that allows ECS container task to make calls to other AWS services"
  value       = module.ecs_task_execution_role.id
}  

output "ecs_task_execution_role_unique_id" {
  description = "The stable and unique string of IAM role that ECS container agent and the Docker daemon can assume"
  value       = module.ecs_task_execution_role.unique_id
}

output "ecs_ec2_instance_profile_role_name" {
  description = "The role name to include in the IAM instance profile for ASG launch configuration."
  value       = module.ecs_ec2_instance_profile_role.*.name
}

output "ecs_ec2_instance_profile_role_arn" {
  description = "The role ARN to include in the IAM instance profile for ASG launch configuration."
  value       = module.ecs_ec2_instance_profile_role.*.arn
}

output "ecs_ec2_instance_profile_name" {
  description = "The IAM instance profile name for ASG launch configuration."
  value       = join(",", aws_iam_instance_profile.ecs_instance_profile.*.name)
}

output "ecs_ec2_instance_profile_arn" {
  description = "The IAM instance profile arn for ASG launch configuration."
  value       = join(",", aws_iam_instance_profile.ecs_instance_profile.*.arn)
}
