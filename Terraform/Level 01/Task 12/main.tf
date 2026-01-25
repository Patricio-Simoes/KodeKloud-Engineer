resource "aws_s3_bucket" "nautilus" {
  bucket = "nautilus-s3-28612"

  tags = {
    Name        = "nautilus-s3-28612"
  }
}

resource "aws_s3_bucket_acl" "nautilus" {
  bucket = aws_s3_bucket.nautilus.id
  acl    = "public-read"
}

# By default, AWS S3 blocks public access to buckets. We need to explicitly disable this block if we want the bucket to be publicly accessible.
resource "aws_s3_bucket_public_access_block" "nautilus" {
  bucket = aws_s3_bucket.nautilus.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}