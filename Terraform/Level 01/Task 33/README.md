---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS VPCs
---
# Task 33 - Delete VPC Using Terraform

Task number 33 was focused on AWS VPCs.

The objective was to **delete a VPC using Terraform**.

**Requirements:**

- Delete a VPC named `xfusion-vpc`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what an AWS VPC is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS VPC? (A recap from previous tasks)

An AWS VPC (Virtual Private Cloud) is a **virtual network** dedicated to an AWS account.

It enables you to launch AWS resources in a logically isolated environment, giving you complete control over your network settings. This includes defining your IP address range, creating subnets, and configuring route tables and network gateways.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_role` to create an IAM Role in AWS.

**Complete Configuration:**

```hcl
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "xfusion-vpc"
  }
}
```

### 3. Terraform Workflow

Once this is done, the required Terraform command is:

```bash
terraform destroy -auto-approve
```

**Purpose:** Destroy all Terraform deployed resources.

## Verification Steps

Once Terraform finishes applying the configuration, verifying the solution requires: 

### 1. Check if the VPC was eliminated

We can check if the VPC was deleted by using the AWS CLI tool:

```bash
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=xfusion-vpc"
```

Expected output:

```bash
[]
```

## Troubleshooting

Surprisingly, no issues occurred during this task!