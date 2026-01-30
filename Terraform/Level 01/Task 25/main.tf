# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.nano"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-99e3cf0be67820413"
  ]

  tags = {
    Name = "devops-ec2"
  }
}