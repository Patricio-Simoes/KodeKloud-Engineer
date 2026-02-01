---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS IAM
---
# Task 32 - Delete IAM Role Using Terraform

Task number 32 was focused on AWS IAM Groups.

The objective was to **delete an IAM Role using Terraform**.

**Requirements:**

- Delete the IAM role named `iamrole_jim`.

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

**Complete Configuration:**

```hcl
resource "aws_iam_role" "role" {
  name = "iamrole_jim"

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

  tags = {
    Name        = "iamrole_jim"
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

### 1. Check if the IAM Role was eliminated

We can check if the IAM Role was deleted by using the AWS CLI tool:

```bash
aws iam get-role --role-name iamgrole_jim
```

Expected output:

```bash
An error occurred (NoSuchEntity) when calling the GetGroup operation: Role iamgrole_jim not found
```

## Troubleshooting

Surprisingly, no issues occurred during this task!