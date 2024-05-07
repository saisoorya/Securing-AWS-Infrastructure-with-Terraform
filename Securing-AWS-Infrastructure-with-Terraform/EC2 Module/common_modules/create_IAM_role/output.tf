output "role" {

    description = "The role name"

    value = aws_iam_role.EC2_role.name
}