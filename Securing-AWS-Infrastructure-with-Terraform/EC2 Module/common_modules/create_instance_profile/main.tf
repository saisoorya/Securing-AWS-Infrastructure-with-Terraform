resource "aws_iam_instance_profile" "EC2_instance_profile" {
  name = var.profile_name
  role = var.role_name
}