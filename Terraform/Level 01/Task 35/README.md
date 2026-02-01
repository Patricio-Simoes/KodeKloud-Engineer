---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS VPCs
---
# Task 35 - VPC Variable Setup Using Terraform

Task number 35 was focused on AWS VPCs.

The objective was to **create a VPC using Terraform**.

**Requirements:**

- The VPC name `nautilus-vpc` should be stored in a variable named `KKE_vpc`;
- The VPC should have a CIDR block of `10.0.0.0/16`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what a VPC is and why it is used;
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
    Name = var.KKE_vpc
  }
}

variable "KKE_vpc" {
  type        = string
  description = "Name of the VPC"
  default     = "nautilus-vpc"
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

### 1. Check if the VPC was created

We can check if the VPC was created with the AWS CLI tool:

```bash
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=nautilus-vpc" | grep "VpcId"
```

Expected output:

```bash
"VpcId": "vpc-d5871ac1df09e7cb0",
```

## Troubleshooting

Surprisingly, no issues occurred during this task!