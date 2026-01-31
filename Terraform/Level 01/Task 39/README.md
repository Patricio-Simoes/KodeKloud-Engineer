---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS IAM
---
# README

Task number 39 was focused on AWS IAM Roles.

The objective was to **create an IAM Role using Terraform**.

**Requirements:**

- The IAM role name `iamrole_ravi` should be stored in a variable named `KKE_iamrole`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what AWS IAM is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is AWS IAM? (A recap from previous tasks)

**AWS IAM (Identity and Access Management)** is a web service that helps securely control access to AWS resources.

It allows us to manage users, groups, roles, and their permissions to ensure that only authorized individuals or systems can access specific AWS resources.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_role` to create an IAM Role in AWS.
- `variable` block, to specify Terraform variables.

**Complete Configuration:**

```hcl
resource "aws_iam_role" "this" {
  name = var.KKE_iamrole
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

variable "KKE_iamrole" {
  type        = string
  description = "Name of the IAM Role"
  default     = "iamrole_ravi"
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

### 1. Check if the IAM Role was created

We can check if the IAM Role was created by using the AWS CLI tool:

```bash
aws iam get-role --role-name iamrole_ravi | grep "Arn"
```

Expected output:

```bash
"Arn": "arn:aws:iam::000000000000:role/iamrole_ravi",
```

## Troubleshooting

Surprisingly, no issues occurred during this task!