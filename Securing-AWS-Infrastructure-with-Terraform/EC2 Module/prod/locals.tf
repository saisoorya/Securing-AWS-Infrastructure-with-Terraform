locals {
  
  IAM_role = toset(["EC2-Role"])

  ec2_instance_name = "Dev-EC2-Instance"

  instance_profile = toset(["EC2-Instance-Profile"])

  ami_name = "ami-08f7912c15ca96832"

  instance_type ="t2.micro"

  #instance_profile = "EC2-Instance-Profile"

}