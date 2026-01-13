resource "aws_ebs_volume" "datacenter_volume" {
  availability_zone = "us-east-1a"
  type              = "gp3"
  size              = 2

  tags = {
    Name = "datacenter-volume"
  }
}