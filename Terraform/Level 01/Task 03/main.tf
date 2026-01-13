resource "aws_vpc" "nautilus-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    # The Name tag defines the name of the VPC in AWS.
    Name = "nautilus-vpc"
  }
}