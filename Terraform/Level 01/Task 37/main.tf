resource "aws_eip" "this" {
  tags = {
    Name = var.KKE_eip
  }
}