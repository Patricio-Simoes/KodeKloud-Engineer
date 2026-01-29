resource "aws_cloudformation_stack" "xfusion" {
  name = "xfusion-stack"

  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Description              = "CloudFormation stack to create an S3 bucket with versioning enabled"

    Resources = {
      xFusionBucket = {
        Type = "AWS::S3::Bucket"
        Properties = {
          BucketName = "xfusion-bucket-21607"
          VersioningConfiguration = {
            Status = "Enabled"
          }
        }
      }
    }
  })
}