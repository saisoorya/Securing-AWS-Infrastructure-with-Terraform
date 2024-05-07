
#Module to create IAM role for the instance profile

module "IAM_role" {

    for_each = local.IAM_role

    source = "../common_modules/create_IAM_role"

    role_name = each.key

}



#Module to create instance profile to attach to EC2 instance

module "EC2_instance_profile" {
  
  for_each = toset(local.instance_profile)

  source = "../common_modules/create_instance_profile"

  profile_name = each.key

  role_name = module.IAM_role["EC2-Role"].role

}



#module to create EC2 instance and attach instance profile to EC2 instance


module "create_ec2_instance" {

  source = "../common_modules/create_ec2_instances"

  ami = local.ami_name

  instance_profile = module.EC2_instance_profile["EC2-Instance-Profile"].profile

  instance_name = local.ec2_instance_name

  instance_type = local.instance_type
  
  
}


#Defining the cross account policy
resource "aws_iam_policy" "cross_account_policy" {

  name = "Cross-account-policy-S3"

  description = "Cross account policy for EC2 instance role"

  policy = file("../common_modules/Policies/EC2_S3_crossaccount.policy")
  
}

#Attaching Cross account policy to IAM Role
resource "aws_iam_role_policy_attachment" "cross_account_policy_attachment" {

  role = module.IAM_role["EC2-Role"].role

  policy_arn = aws_iam_policy.cross_account_policy.arn
  
}

#Defining SSM policy
resource "aws_iam_policy" "SSM_policy" {

  name = "SSM-Custom_Policy"

  description = "SSM instance role"

  policy = file("../common_modules/Policies/SSM_policy.policy")
  
}

#Attaching SSM policy to IAM Role
resource "aws_iam_role_policy_attachment" "SSM_policy_attachment" {

  role = module.IAM_role["EC2-Role"].role

  policy_arn = aws_iam_policy.SSM_policy.arn
  
}




#Module to create instance profile to attach to EC2 instance

/*
resource "aws_iam_instance_profile" "EC2_instance_profile" {
  
  for_each = toset(local.IAM_role)
  name = "EC2-instance-profile"
  role = module.IAM_role[each.key].role

}
*/


/*
#Module to create instance profile to attach to EC2 instance
module "EC2_instance_profile" {
  
  for_each = toset(local.IAM_role)

  source = "../common_modules/create_instance_profile"

  profile_name = local.instance_profile

  role_name = module.IAM_role[each.key].role

}
*/


#module to create EC2 instance and attach instance profile to EC2 instance

/*
resource "aws_instance" "web" {

  #for_each = toset(local.instance_profile)

  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"

  iam_instance_profile = module.EC2_instance_profile["EC2-Instance-Profile"].profile
  
  tags = {
     Name = "Test-Instance"
  }
}
*/