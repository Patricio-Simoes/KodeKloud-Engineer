resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "nautilus-s3-5188"
  acl    = "private"

  tags = {
    Name = "nautilus-s3-5188"
  }
}

resource "aws_s3_bucket_versioning" "s3_ran_bucket_versioning" {
  bucket = aws_s3_bucket.s3_ran_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}