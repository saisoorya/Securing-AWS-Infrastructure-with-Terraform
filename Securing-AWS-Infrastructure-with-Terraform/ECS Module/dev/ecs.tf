module "cy7900_usw2" {
    source = "../common_modules/ecs"

    app_name = local.app_name
    common_tags = local.common_tags
    ec2_instance_count_max = 1
    ec2_instance_count_min = 1
    app_count              = 1
    cpu                    = 512
    memory                 = 512
    key_name               = "dev_ec2"
    app_image                   = "269471155370.dkr.ecr.us-west-2.amazonaws.com/cy7900:${data.aws_ssm_parameter.app_image.value}"
    ec2_instance_profile_name   = module.cy7900_ecs_iam.ecs_ec2_instance_profile_name
    ecs_task_execution_role_arn = module.cy7900_ecs_iam.ecs_task_execution_role_arn
    ecs_task_role_arn           = module.cy7900_ecs_iam.ecs_task_role_arn
    assign_public_ip            = true
    environment = [
        {
            name = "aws.region"
            value = "us-west2"
        },
        {
            name = "env"
            value = "dev"
        }        
    ]
}

data "aws_ssm_parameter" "app_image" {
    name = "/cy7900-ecs/image/version"
}