---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS S3
---
# README

Task number 29 was focused on AWS S3 Bucket backups.

The objective was to **copy the contents of an S3 bucket to a local directory and delete the existing S3 bucket using Terraform**.

**Requirements:**

- Copy the contents of `xfusion-bck-28485` S3 bucket to `/opt/s3-backup/` directory;
- Delete the S3 bucket `xfusion-bck-28485`.

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

- `null_resource` to deploy a "do-nothing container" for arbitrary actions taken by a provisioner.

**Complete Configuration:**

```hcl
resource "null_resource" "aws_cli" {
  provisioner "local-exec" {
    command = "aws s3 cp s3://xfusion-bck-28485 /opt/s3-backup/ --recursive && aws s3 rm s3://xfusion-bck-28485 --recursive && aws s3api delete-bucket --bucket xfusion-bck-28485"
  }
}
```

This command will make use of the AWS CLI tool to interact with the existing S3 bucket in AWS.

This is required due to the fact that this bucket was not created using the standard Terraform resource.

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

### 1. Check if a backup was make to `opt/s3-backup`

We can check if backup was made to `/opt/s3-backup` by listing the files in that directory:

```bash
ls /opt/s3-backup
```

Expected output:

```bash
nautilus.txt
```

### 2. Check if the S3 bucket was deleted

We can check if the S3 bucket still exists by using the AWS CLi tool:

```bash
aws s3 ls
```

Expected output:

No output.

## Troubleshooting

Surprisingly, no issues occurred during this task!