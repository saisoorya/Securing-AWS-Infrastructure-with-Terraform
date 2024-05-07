output "profile" {

    description = "The role name"

    value = aws_iam_instance_profile.EC2_instance_profile.name
}