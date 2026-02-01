---
date: 29-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - CloudFormation
---
# Task 22 - CloudFormation Template Deployment Using Terraform

Task number 22 was focused on AWS CloudFormation.

The objective was to **to create a CloudFormation stack that provisions an S3 bucket with versioning enabled using Terraform**.

**Requirements:**

- Create a CloudFormation stack named `xfusion-stack`.
- This stack should contain an S3 bucket named `xfusion-bucket-21607`;
- The bucket must have versioning enabled.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what CloudFormation is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is AWS CloudFormation?

AWS CloudFormation is Amazon’s Infrastructure as Code (IaC) service.

It lets us define, provision, and manage AWS resources using text files (templates) instead of clicking around in the console.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_cloudformation_stack` to create the CloudFormation stack in AWS.

**Complete Configuration:**

```hcl
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
```

### 3. Terraform Workflow

Once the code is ready, the standard Terraform workflow applies:

```bash
terraform init
```

**Purpose:** Initialize the Terraform working directory and download required providers.

```bash
# Format the configuration
terraform fmt

# Validate the configuration
terraform validate
```

**Purpose:** Ensure code formatting consistency and validate syntax correctness.

```bash
# Review the execution plan
terraform plan

# Apply the configuration
terraform apply -auto-approve
```

**Purpose:** Review the execution plan, then apply it to create the new resources automatically.

## Verification Steps

Once Terraform finishes applying the configuration, verifying the solution requires: 

### 1. Check if the CloudFormation stack was created on AWS

We can check if the stack was created by looking for it's ARN:

```bash
terraform state show aws_cloudformation_stack.xfusion | grep "arn"
```

Expected output:

```bash
id = "arn:aws:cloudformation:us-east-1:000000000000:stack/xfusion-stack/7b84a2c0-5912-4f5e-8cc2-a9d40fcf59eb"
```

### 2. Check if the S3 Bucket was created on AWS

We can check if the S3 Bucket was created using the AWS CLI tool:

```bash
aws s3api head-bucket --bucket xfusion-bucket-21607
```

Expected output:

```bash
{
    "BucketRegion": "us-east-1"
}
```

### 3. Check if the S3 Bucket has versioning enabled

We can check if versioning is enabled using the AWS CLI tool:

```bash
 aws s3api get-bucket-versioning \
  --bucket xfusion-bucket-21607
```

Expected output:

```bash
{
    "Status": "Enabled"
}
```

## Troubleshooting

Originally, i named the Bucket resource `xfusion_buxket`, this threw an error stating that:

```bash
Error: creating CloudFormation Stack (xfusion-stack): operation error CloudFormation: CreateStack, https response error StatusCode: 400, RequestID: 4e3dfbc0-3e24-46e7-ae3a-3886f75f02c9, api error ValidationError: Template format error: Resource name xfusion_bucket is non alphanumeric.
```

This was fixed by changing deleting the resource:

```bash
aws cloudformation delete-stack \
  --stack-name xfusion-stack
```

Followed by changing the resource name to `xFusionBucket`.