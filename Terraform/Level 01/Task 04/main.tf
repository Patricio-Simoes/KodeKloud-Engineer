resource "aws_vpc" "nautilus-vpc" {
  cidr_block                       = "192.168.0.0/24"
  assign_generated_ipv6_cidr_block = true

  tags = {
    # The Name tag defines the name of the VPC in AWS.
    Name = "nautilus-vpc"
  }
}