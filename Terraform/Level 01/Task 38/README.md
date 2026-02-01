---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS IAM
---
# Task 38 - User Variable Setup Using Terraform

Task number 38 was focused on AWS IAM Users.

The objective was to **create an IAM User using Terraform**.

**Requirements:**

- The IAM User name `iamuser_mark` should be stored in a variable named `KKE_user`.

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

- `aws_iam_user` to create an IAM User in AWS.
- `variable` block, to specify Terraform variables.

**Complete Configuration:**

```hcl
resource "aws_iam_user" "this" {
  name = var.KKE_user
}

variable "KKE_user" {
  type        = string
  description = "Name of the IAM User"
  default     = "iamuser_mark"
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

### 1. Check if the IAM User was created

We can check if the IAM User was created by using the AWS CLI tool:

```bash
aws iam get-user --user-name iamuser_mark
```

Expected output:

```bash
{
    "User": {
        "Path": "/",
        "UserName": "iamuser_mark",
        "UserId": "z5ksrcdjrn47kqgt3lwy",
        "Arn": "arn:aws:iam::000000000000:user/iamuser_mark",
        "CreateDate": "2026-01-31T18:14:33.357639Z"
    }
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!