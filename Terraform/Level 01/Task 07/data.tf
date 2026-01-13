# Get information about the default VPC.
data "aws_vpc" "vpc" {
  default = true
}

# Get information about the default security group in that VPC.
data "aws_security_group" "sg" {
  name   = "default"
  vpc_id = data.aws_vpc.vpc.id
}