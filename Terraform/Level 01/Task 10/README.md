---
date: "2025-11-17"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS EBS Snapshots
---
# README

Task number 10 was focused on creating AWS EBS volume snapshots.

The objective was to **create an a snapshot of an existing volume in AWS using Terraform**.

**Requirements:**

- The existing volume is named `xfusion-vol`;
- The name of the snapshot must be `xfusion-vol-ss`;
- The description must be `Xfusion Snapshot`;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS Snapshot is and why it is used.
2. Write the Terraform configuration to create the resources.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS EBS Snapshot?

An EBS snapshot is a point-in-time, incremental backup of an Amazon EBS (Elastic Block Store) volume in AWS.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_ebs_snapshot` to create an EBS Snapshot in AWS.

Below is the complete configuration that meets the requirements:

```hcl
resource "aws_ebs_volume" "k8s_volume" {
  availability_zone = "us-east-1a"
  size              = 5
  type              = "gp2"

  tags = {
    Name = "xfusion-vol"
  }
}

resource "aws_ebs_snapshot" "xfusion_ss" {
  volume_id   = aws_ebs_volume.k8s_volume.id
  description = "Xfusion Snapshot"

  tags = {
    Name = "xfusion-vol-ss"
  }
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

### 1. Check if the EBS Snapshot was created on AWS

```bash
terraform state show aws_ebs_snapshot.xfusion_ss
```

Expected output:

```bash
resource "aws_ebs_snapshot" "xfusion_ss" {
    arn                    = "arn:aws:ec2:us-east-1::snapshot/snap-83122af85fb962d04"
    data_encryption_key_id = null
    description            = "Xfusion Snapshot"
    encrypted              = false
    id                     = "snap-83122af85fb962d04"
    kms_key_id             = null
    outpost_arn            = null
    owner_alias            = null
    owner_id               = "000000000000"
    storage_tier           = null
    tags                   = {
        "Name" = "xfusion-vol-ss"
    }
    tags_all               = {
        "Name" = "xfusion-vol-ss"
    }
    volume_id              = "vol-ae47094dbabc42b7b"
    volume_size            = 5
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!