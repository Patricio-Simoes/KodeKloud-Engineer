---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - IAM
---
# README

Task number 27 was focused on AWS IAM.

The objective was to **attach an existing IAM policy to an existing IAM user using Terraform**.

**Requirements:**

- An IAM user named `iamuser_ammar` and a policy named `iampolicy_ammar` already exists;
- Use Terraform to attach the IAM policy `iampolicy_ammar` to the IAM user `iamuser_ammar`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what AWS is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is AWS IAM? (A recap from previous tasks)

**AWS IAM (Identity and Access Management)** is a web service that helps securely control access to AWS resources.

It allows us to manage users, groups, roles, and their permissions to ensure that only authorized individuals or systems can access specific AWS resources.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_user` to create the IAM user in AWS;
- `aws_iam_policy` to the IAM policy in AWS;
- `aws_iam_user_policy_attachment` to attach a managed IAM Policy to an IAM user.

**Complete Configuration:**

```hcl
# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_ammar"

  tags = {
    Name = "iamuser_ammar"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_ammar"
  description = "IAM policy allowing EC2 read actions for ammar"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "ammar" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
```

### 3. Terraform Workflow

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

### 1. Check if the policy was attached to the user

We can check if the policy was attached to the user by looking at the `aws_iam_user_policy_attachment` resource on the state file:

```bash
terraform state show aws_iam_user_policy_attachment.ammar
```

Expected output:

```bash
# aws_iam_user_policy_attachment.ammar:
resource "aws_iam_user_policy_attachment" "ammar" {
    id         = "iamuser_ammar-20260130164404347100000001"
    policy_arn = "arn:aws:iam::000000000000:policy/iampolicy_ammar"
    user       = "iamuser_ammar"
}
```

This confirms that the policy is created and attached to the IAM user `ìamuser_ammar`.

## Troubleshooting

Surprisingly, no issues occurred during this task!