---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS S3
---
# Task 34 - Copy Data to S3 Using Terraform

Task number 34 was focused on AWS S3.

The objective was to **copy data to an S3 Bucket using Terraform**.

**Requirements:**

- S3 bucket named `devops-cp-2454` already exists;
- Copy the file `/tmp/devops.txt` to s3 bucket `devops-cp-2454`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what an S3 Bucket is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS S3 Bucket? (A recap from previous tasks)

An AWS S3 (Simple Storage Service) bucket is a scalable, cloud-based storage container for objects (files) such as images, videos, documents, and backups.

Each bucket has a globally unique name and can store an unlimited number of objects.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_role` to create an IAM Role in AWS.

**Complete Configuration:**

```hcl
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
```

### 3. Terraform Workflow

Once this is done, the standard Terraform workflow applies:

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

### 1. Check if the `devops.txt`file is present in the S3

We can check if the file is present by using the AWS CLI tool:

```bash
aws s3 ls s3://devops-cp-2454
```

Expected output:

```bash
2026-01-31 16:49:31         27 devops.txt
```

## Troubleshooting

Surprisingly, no issues occurred during this task!