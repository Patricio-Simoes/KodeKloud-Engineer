resource "aws_security_group" "datacenter-sg" {
  name        = "datacenter-sg"
  description = "Security group for Nautilus App Servers"
  region      = "us-east-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  # The security_group_id binds the rule to the security group.
  security_group_id = aws_security_group.datacenter-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  # HTTP uses TCP, therefore, ip_protocol = "tcp".
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  # The security_group_id binds the rule to the security group.
  security_group_id = aws_security_group.datacenter-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  # HTTP uses TCP, therefore, ip_protocol = "ssh".
  ip_protocol = "tcp"
  to_port     = 22
}