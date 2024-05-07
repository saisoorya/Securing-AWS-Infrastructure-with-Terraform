locals {
  
  IAM_role = toset(["EC2-Role"])

  ec2_instance_name = "Dev-EC2-Instance"

  instance_profile = toset(["EC2-Instance-Profile"])

  ami_name = "ami-08f7912c15ca96832"

  instance_type ="t2.micro"

  key_name = "dev_ec2"

  security_group = ["sg-0226fb3f47f089317"]

  subnet_id = "subnet-04d7489e72922980b"
  


  #instance_profile = "EC2-Instance-Profile"

}