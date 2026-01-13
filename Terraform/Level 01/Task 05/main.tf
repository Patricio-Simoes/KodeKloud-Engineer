resource "aws_vpc" "datacenter-vpc" {
  cidr_block = "192.168.0.0/24"

  tags = {
    # The Name tag defines the name of the VPC in AWS.
    Name = "datacenter-vpc"
  }
}