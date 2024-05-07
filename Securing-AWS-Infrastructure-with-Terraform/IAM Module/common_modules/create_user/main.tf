#Creating IAM Users


resource "aws_iam_user" "developers" {

  name  = var.user_name
  path  = "/"
}





