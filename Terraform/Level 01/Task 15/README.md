---
date: 25-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - IAM
---
# README

Task number 15 was focused on creating IAM groups on AWS.

The objective was to **create an IAM group named `iamgroup_anita` using Terraform**.

**Requirements:**

- Create an IAM group named `iamgroup_anita` using terraform.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what AWS IAM is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is AWS IAM?

**AWS IAM (Identity and Access Management)** is a web service that helps securely control access to AWS resources.

It allows us to manage users, groups, roles, and their permissions to ensure that only authorized individuals or systems can access specific AWS resources.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_user` to create the AWS IAM user.

**Complete Configuration:**

```hcl
resource "aws_iam_group" "anita" {
  name = "iamgroup_anita"
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

### 1. Check if the IAM group was created on AWS

We can check if the group was created by looking for it's ARN:

```bash
terraform state show aws_iam_group.anita | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:iam::000000000000:group/iamgroup_anita"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!