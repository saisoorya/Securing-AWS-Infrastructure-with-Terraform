resource "aws_security_group" "cy7900_sg" {
  name        = "cy7900"
  description = "The cy7900 project security group"
  vpc_id      = data.aws_vpc.selected.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.app_name}-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.cy7900_sg.id
  cidr_ipv4         = "155.33.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_vpn" {
  security_group_id = aws_security_group.cy7900_sg.id
  cidr_ipv4         = "76.19.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.cy7900_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ecs" {
  security_group_id = aws_security_group.cy7900_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 51678
  ip_protocol       = "tcp"
  to_port           = 51678
}

resource "aws_vpc_security_group_egress_rule" "egress_all" {
  security_group_id = aws_security_group.cy7900_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}