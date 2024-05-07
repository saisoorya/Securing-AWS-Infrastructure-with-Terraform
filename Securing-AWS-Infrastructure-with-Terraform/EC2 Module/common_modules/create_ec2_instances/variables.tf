variable "ami" {
  description = "AMI id"
  type        = string
}


variable "instance_name" {

  description = "Instance Name"
  type = string
  
}

variable "instance_profile" {

  description = "Instance Name"
  type = string
  
}

variable "instance_type" {

  description = "Instance Type"
  type = string
  
}

variable "key_name" {

  description = "Key Name"
  type = string
  
}

variable "security_group" {

  description = "Group Name"
  type = list(string)
  
}

variable "subnet_id" {

  description = "Subnet id"
  type = string
  
}