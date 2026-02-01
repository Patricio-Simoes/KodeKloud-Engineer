---
date: "2026-01-25"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS S3
---
# Task 13 - Create Private S3 Bucket Using Terraform

Task number 13 was focused on creating a private S3 bucket on AWS.

The objective was to **create S3 bucket using Terraform**.

**Requirements:**

- The name of the S3 bucket must be `nautilus-s3-17198`;
- The S3 bucket must block all public access, making it a private bucket.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Look back at Task 12 and understand how to create a private S3;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What needs to change in Task 12?

Task 12 created a publicly accessible S3 bucket, this time, we want to create a private S3. For this:

- The bucket's ACL must deny all public access;
- By default, AWS S3 blocks public access to buckets. Instead of explicitly disabling this, it will remain as default.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_s3_bucket` to create the S3 Bucket AWS;
- `aws_s3_bucket_acl` to create the S3 bucket ACL;
- `aws_s3_bucket_public_access_block` to manage the S3 bucket-level public access configuration.

**Complete Configuration:**

```hcl
resource "aws_s3_bucket" "nautilus" {
  bucket = "nautilus-s3-17198"

  tags = {
    Name        = "nautilus-s3-17198"
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

### 1. Check if the S3 Bucket was created on AWS

We can check if the bucket was created by looking for it's DNS endpoint:

```bash
terraform state show aws_s3_bucket.nautilus | grep "bucket_domain_name"
```

Expected output:

```bash
bucket_domain_name = "nautilus-s3-17198.s3.amazonaws.com"
```

### 2. Check if the S3 Bucket is not accessible publicly

We can check if the bucket is not accessible publicly by inspecting it's ACL:

```bash
terraform state show aws_s3_bucket_acl.nautilus | grep "acl"
```

Expected output:

```bash
resource "aws_s3_bucket_acl" "nautilus" {
    acl = "private"
}
```

Ensuring that public access is blocked at the bucket level requires:

```bash
terraform state show aws_s3_bucket_public_access_block.nautilus
```

Expected output:

```bash
resource "aws_s3_bucket_public_access_block" "nautilus" {
    block_public_acls       = true
    block_public_policy     = true
    bucket                  = "nautilus-s3-17198"
    id                      = "nautilus-s3-17198"
    ignore_public_acls      = true
    restrict_public_buckets = true
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!