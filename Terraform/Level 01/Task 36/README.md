---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS Security Groups
---
# README

Task number 35 was focused on AWS Security Groups.

The objective was to **create a Security Group using Terraform**.

**Requirements:**

- The Security Group name `devops-sg` should be stored in a variable named `KKE_sg`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what a Security Groups is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS Security Group? (A recap from previous tasks)

An AWS Security Group is a **virtual firewall that controls inbound and outbound traffic** to AWS resources.

It enables you to secure your cloud environment by defining rules that specify what traffic is allowed or denied.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_security_group` to create a Security Group in AWS.
- `variable` block, to specify Terraform variables.

**Complete Configuration:**

```hcl
resource "aws_security_group" "this" {
  name = var.KKE_sg
}

variable "KKE_sg" {
  type        = string
  description = "Name of the Security Group"
  default     = "devops-sg"
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

### 1. Check if the Security Group was created

We can check if the Security Group was created with the AWS CLI tool:

```bash
aws ec2 describe-security-groups --filters "Name=group-name,Values=devops-sg" | grep "SecurityGroupArn"
```

Expected output:

```bash
"SecurityGroupArn": "arn:aws:ec2:us-east-1:000000000000:security-group/sg-aff9b14894b3ea004",
```

## Troubleshooting

Surprisingly, no issues occurred during this task!