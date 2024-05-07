#Creating a User

module "create_iam_users" {

    for_each = local.IAM_Users
    source = "../common_modules/create_user"
    user_name = each.key
  
}


#Providing users with console access

resource "aws_iam_user_login_profile" "user_login_profile" {
  for_each = toset(local.IAM_Users)
  user                    = module.create_iam_users[each.key].name
  password_length         = 16
  password_reset_required = true

  lifecycle {
    ignore_changes = [ 
      password_reset_required,
     ]
  }
  
}

#Creating a group
module "create_iam_group" {

    for_each = local.IAM_Groups
    source = "../common_modules/create_group"
    group_names = each.key
}

#adding members to a group
resource "aws_iam_user_group_membership" "dev_members" {
  
  for_each = toset(local.IAM_Users)

  user = module.create_iam_users[each.key].name

  groups = [module.create_iam_group["developers"].groups]
}


#Create S3 Policy
resource "aws_iam_policy" "EC2CustomPolicy" {

  name = "EC2-Custom"

  description = "EC2 Custom policy"

  policy = file("../common_modules/policies/EC2_Read&Write_custom.policy")
}

#Create EC2 Policy
resource "aws_iam_policy" "S3CustomPolicy" {

  name = "S3-Custom"
  
  description = "S3 Custom Policy"

  policy = file("../common_modules/policies/S3Custom.policy")
  
}


#create dyanamodb policy
resource "aws_iam_policy" "cy7900_dynamodb_policy" {
  name        = "cy7900-dynamodb"
  description = "cy7900 dynamodb policy"
  policy      = file("../common_modules/policies/dynamodb.policy")
}


#Create IAM Credentials policy

resource "aws_iam_policy" "IAM_Credentials_policy" {

  name = "IAM-custom-creds"
  description = "IAM Credentials custom policy"
  policy = file("../common_modules/policies/IAM_Credentials.policy")
  
}

#Create ECS_Permissions policy

resource "aws_iam_policy" "ECS_permission_policy" {

  name = "ECS-Custom-Permissions"
  description = "ECS Permissions Custom Policy"
  policy = file("../common_modules/policies/ECS_Permissions.policy")
  
}

#Create ECS_AWS_Managed_policy

resource "aws_iam_policy" "ECS_AWS_Managed_policy" {

  name = "ECS-AWS-Managed-Policy"
  description = "AWS maged policies for ECS"
  policy = file("../common_modules/policies/ECS_AWS_Managed.policy")
  
}

#Defining SSM policy
resource "aws_iam_policy" "SSM_policy" {

  name = "SSM-Custom-Policy"

  description = "SSM instance role"

  policy = file("../common_modules/policies/SSM_policy.policy")
  
}

#Defining ECR policy
resource "aws_iam_policy" "ECR_Policy" {

  name = "ECR-Custom-Policy"

  description = "ECR Permissions Custom Policy"

  policy = file("../common_modules/policies/ECR.policy")
  
}






#Attach S3 policy to group
resource "aws_iam_group_policy_attachment" "CustomS3" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.S3CustomPolicy.arn
  
}


#Attach EC2 policy to group
resource "aws_iam_group_policy_attachment" "CustomEC2" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.EC2CustomPolicy.arn
  
}

#Attach Dynamodb policy to group
resource "aws_iam_group_policy_attachment" "cy7900_dev" {
  group      = module.create_iam_group["developers"].groups
  policy_arn = aws_iam_policy.cy7900_dynamodb_policy.arn
}

#Attach IAM Credentials policy to group

resource "aws_iam_group_policy_attachment" "CustomIAMcreds" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.IAM_Credentials_policy.arn
  
}

#Attach ECS permission policy to group

resource "aws_iam_group_policy_attachment" "ECScustompermissions" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.ECS_permission_policy.arn
  
}

#Attach AWS Managed ECS policies to group

resource "aws_iam_group_policy_attachment" "ECSAWS_managedpolicy" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.ECS_AWS_Managed_policy.arn


}

#Attaching ECR policy to IAM Group

resource "aws_iam_group_policy_attachment" "ECR_policy_attachment" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.ECR_Policy.arn
  
}


#Attaching SSM policy to IAM Role
resource "aws_iam_group_policy_attachment" "SSM_policy_attachment" {

  group = module.create_iam_group["developers"].groups

  policy_arn = aws_iam_policy.SSM_policy.arn
  
}







/*
# Normal way to create group

resource "aws_iam_group" "dev_group" {
  
  name = "Developers"
}
*/



#Normal Way to add users to group
/*
resource "aws_iam_group_membership" "dev_members" {
  for_each = local.IAM_Users

  name  = "dev_members"

  users = [module.create_iam_users[each.key].name]
  
  group = aws_iam_group.dev_group.name
}
*/

#Normal way to attach policies to group

/*

resource "aws_iam_group_policy_attachment" "CustomS3" {

  group = aws_iam_group.dev_group.name

  policy_arn = aws_iam_policy.S3CustomPolicy.arn
  
}


resource "aws_iam_group_policy_attachment" "CustomEC2" {

  group = aws_iam_group.dev_group.name

  policy_arn = aws_iam_policy.EC2CustomPolicy.arn
  


}

*/