---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS S3
---
# Task 28 - Enable S3 Versioning Using Terraform

Task number 28 was focused on AWS S3 Bucket versioning.

The objective was to **enable versioning for an existing S3 bucket using Terraform**.

**Requirements:**

- The S3 bucket name is `nautilus-s3-5188`, enable versioning for this bucket using Terraform.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what AWS S3 is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS S3 Bucket?

An AWS S3 (Simple Storage Service) bucket is a scalable, cloud-based storage container for objects (files) such as images, videos, documents, and backups.

Each bucket has a globally unique name and can store an unlimited number of objects.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_s3_bucket` to create the S3 bucket in AWS;
- `aws_s3_bucket_versioning` to manage S3 bucket versioning.

**Complete Configuration:**

```hcl
resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "nautilus-s3-5188"
  acl    = "private"

  tags = {
    Name        = "nautilus-s3-5188"
  }
}

resource "aws_s3_bucket_versioning" "s3_ran_bucket_versioning" {
  bucket = aws_s3_bucket.s3_ran_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
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

### 1. Check if bucket versioning is enabled

We can check if the policy was attached to the user by looking at the `aws_iam_user_policy_attachment` resource on the state file:

```bash
terraform state show aws_s3_bucket_versioning.s3_ran_bucket_versioning
```

Expected output:

```bash
# aws_s3_bucket_versioning.versioning_example:
resource "aws_s3_bucket_versioning" "versioning_example" {
    bucket                = "nautilus-s3-5188"
    expected_bucket_owner = null
    id                    = "nautilus-s3-5188"

    versioning_configuration {
        mfa_delete = null
        status     = "Enabled"
    }
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!