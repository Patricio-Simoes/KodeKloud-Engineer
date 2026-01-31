resource "aws_s3_bucket" "my_bucket" {
  bucket = "devops-cp-2454"
  acl    = "private"

  tags = {
    Name = "devops-cp-2454"
  }
}

resource "null_resource" "aws_cli" {
  provisioner "local-exec" {
    command = "aws s3 cp /tmp/devops.txt s3://devops-cp-2454"
  }
}