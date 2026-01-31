resource "aws_dynamodb_table" "table" {
  name         = "devops-users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "devops_id"

  attribute {
    name = "devops_id"
    type = "S"
  }
  tags = {
    Name = "devops-users"
  }
}