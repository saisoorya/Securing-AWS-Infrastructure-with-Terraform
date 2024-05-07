resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = var.security_group
  subnet_id = var.subnet_id



  iam_instance_profile = var.instance_profile
  
  tags = {
     Name = var.instance_name
  }

  lifecycle {

    ignore_changes = [

      security_groups, vpc_security_group_ids
       
     ]
  }
}
