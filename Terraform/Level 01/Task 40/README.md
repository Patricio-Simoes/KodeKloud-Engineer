---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS IAM
---
# Task 40 - Policy Variable Setup Using Terraform

Task number 40 was focused on AWS IAM Policies.

The objective was to **create an IAM Policy using Terraform**.

**Requirements:**

- The IAM policy name `iampolicy_jim` should be stored in a variable named `KKE_iampolicy`.

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

- `aws_iam_policy` to create an IAM Policy in AWS.
- `variable` block, to specify Terraform variables.

**Complete Configuration:**

```hcl
resource "aws_iam_policy" "this" {
  name = var.KKE_iampolicy
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

variable "KKE_iampolicy" {
  type        = string
  description = "Name of the IAM Role"
  default     = "iampolicy_jim"
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

### 1. Check if the IAM Policy was created

We can check if the IAM Policy was created by using the AWS CLI tool:

```bash
aws iam list-policies --query 'Policies[?PolicyName==`iampolicy_jim`]' | grep "Arn"
```

Expected output:

```bash
"Arn": "arn:aws:iam::000000000000:policy/iampolicy_jim",
```

## Troubleshooting

Surprisingly, no issues occurred during this task!