---
date: "2026-01-25"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS S3
---
# README

Task number 12 was focused on creating a public S3 bucket on AWS.

The objective was to **create a public S3 bucket using Terraform**.

**Requirements:**

- Create a public S3 bucket named `nautilus-s3-28612` using Terraform;
- Ensure the bucket is accessible publicly once created by setting the proper ACL.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS S3 Bucket is and why it is used.
2. Understand how an AWS S3 Bucket is set to publicly accessible.
3. Write the Terraform configuration to create the resources.
4. Initialize and apply the Terraform workflow to create the infrastructure.
5. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS S3 Bucket?

An AWS S3 (Simple Storage Service) bucket is a scalable, cloud-based storage container for objects (files) such as images, videos, documents, and backups.

Each bucket has a globally unique name and can store an unlimited number of objects.

### 2. What does an S3 require to be publicly accessible?

To make an S3 bucket publicly accessible, the following conditions must be met:

- The bucket's ACL must allow public read access;
- By default, AWS S3 blocks public access to buckets. This block must explicitly be disabled.

### 3. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_s3_bucket` to create the S3 Bucket AWS;
- `aws_s3_bucket_acl` to create the S3 bucket ACL;
- `aws_s3_bucket_public_access_block` to manage the S3 bucket-level public access configuration.

**Complete Configuration:**

```hcl
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
```

### 4. Terraform Workflow

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
bucket_domain_name = "nautilus-s3-28612.s3.amazonaws.com"
```

### 2. Check if the S3 Bucket is accessible publicly

We can check if the bucket is accessible publicly by inspecting it's ACL:

```bash
terraform state show aws_s3_bucket_acl.nautilus | grep "acl"
```

Expected output:

```bash
resource "aws_s3_bucket_acl" "nautilus" {
    acl = "public-read"
}
```

Ensuring that public access is not blocked at the bucket level requires:

```bash
terraform state show aws_s3_bucket_public_access_block.nautilus
```

Expected output:

```bash
resource "aws_s3_bucket_public_access_block" "nautilus" {
    block_public_acls       = false
    block_public_policy     = false
    bucket                  = "nautilus-s3-28612"
    id                      = "nautilus-s3-28612"
    ignore_public_acls      = false
    restrict_public_buckets = false
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!