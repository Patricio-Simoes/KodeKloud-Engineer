---
date: "2025-11-15"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS EBS Volumes
---
# README

Task number 9 was focused on creating AWS EBS volumes.

The objective was to **create an EBS volume in AWS using Terraform**.

**Requirements:**

- Create an EBS volume named `datacenter-volume`;
- The volume type must be `gp3`;
- The volume size must be `2 GB`;
- The volume must be created on `us-east-1`

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS EBS volume is and why it is used.
2. Write the Terraform configuration to create the resources.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS EBS volume?

An Amazon EBS (Elastic Block Store) volume is a block-level storage device that you can attach to an EC2 instance.

> [!summary] In Short
> Think of it like a virtual hard drive in the cloud.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_ebs_volume` to create an EBS volume in AWS.

Below is the complete configuration that meets the requirements:

```hcl
resource "aws_ebs_volume" "datacenter_volume" {
  availability_zone = "us-east-1a"
  type = "gp3"
  size = 2

  tags = {
    Name = "datacenter-volume"
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

### 1. Check if the EBS volume was created on AWS

```bash
erraform state show aws_ebs_volume.datacenter_volume
```

Expected output:

```bash
resource "aws_ebs_volume" "datacenter_volume" {
    arn                  = "arn:aws:ec2:us-east-1::volume/vol-b52475dede707cfa8"
    availability_zone    = "us-east-1a"
    encrypted            = false
    final_snapshot       = false
    id                   = "vol-b52475dede707cfa8"
    iops                 = 3000
    kms_key_id           = null
    multi_attach_enabled = false
    outpost_arn          = null
    size                 = 2
    snapshot_id          = null
    tags                 = {
        "Name" = "datacenter-volume"
    }
    tags_all             = {
        "Name" = "datacenter-volume"
    }
    throughput           = 0
    type                 = "gp3"
}
```

## Troubleshooting

Even though the [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) mentions that it is possible to define a region at resource level, i got an error stating that "region is not expecting here".

This forces the region to be defined at the provider level.