---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS IAM
---
# README

Task number 31 was focused on AWS IAM Groups.

The objective was to **delete an IAM Group using Terraform**.

**Requirements:**

- Delete an IAM group named `iamgroup_rose`.

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

- `aws_iam_group` to create an IAM Group in AWS.

**Complete Configuration:**

```hcl
resource "aws_iam_group" "this" {
  name = "iamgroup_rose"
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

### 1. Check if the IAM Group was eliminated

We can check if the IAM Group was deleted by using the AWS CLI tool:

```bash
aws iam get-group --group-name iamgroup_rose
```

Expected output:

```bash
An error occurred (NoSuchEntity) when calling the GetGroup operation: Group iamgroup_rose not found
```

## Troubleshooting

Surprisingly, no issues occurred during this task!