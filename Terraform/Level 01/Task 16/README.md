---
date: 25-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - IAM
---
# Task 16 - Create IAM Policy Using Terraform

Task number 16 was focused on creating IAM policies on AWS.

The objective was to **create an IAM policy named `iampolicy_john` using Terraform**.

**Requirements:**

- Create an IAM policy named `iampolicy_john`;
- It must allow read-only access to the EC2 console, i.e., this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what AWS IAM is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is AWS IAM?

AWS IAM, (Identity and Access Management), is a web service that helps securely control access to AWS resources.

It allows us to manage users, groups, roles, and their permissions to ensure that only authorized individuals or systems can access specific AWS resources.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_user` to create the AWS IAM user.

**Complete Configuration:**

```hcl
resource "aws_iam_policy" "iampolicy_john" {
  name        = "iampolicy_john"
  description = "Allows read-only access to EC2 instances, AMIs, and snapshots"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
          "ec2:DescribeVolumes",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeTags",
          "ec2:DescribeRegions",
          "ec2:DescribeAvailabilityZones"
        ]
        Resource = "*"
      }
    ]
  })
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

### 1. Check if the IAM policy was created on AWS

We can check if the policy was created by looking for it's ARN:

```bash
terraform state show aws_iam_policy.iampolicy_john | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:iam::000000000000:policy/iampolicy_john"
id = "arn:aws:iam::000000000000:policy/iampolicy_john"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!