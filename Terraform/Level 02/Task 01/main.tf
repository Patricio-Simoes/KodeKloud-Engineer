resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/24"

  tags = {
    Name = var.KKE_VPC_NAME
  }
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.KKE_SUBNET_NAME
  }

  depends_on = [aws_vpc.this]
}