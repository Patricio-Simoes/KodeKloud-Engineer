resource "aws_eip" "xfusion-eip" {
  domain = "vpc"
  tags = {
    Name = "xfusion-eip"
  }
}