resource "aws_s3_bucket" "nautilus" {
  bucket = "nautilus-s3-17198"

  tags = {
    Name = "nautilus-s3-17198"
  }
}

resource "aws_s3_bucket_acl" "nautilus" {
  bucket = aws_s3_bucket.nautilus.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "nautilus" {
  bucket = aws_s3_bucket.nautilus.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}