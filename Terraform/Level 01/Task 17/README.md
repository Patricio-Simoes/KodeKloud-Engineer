---
date: 25-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - DynamoDB
---
# Task 17 - Create DynamoDB Table Using Terraform

Task number 17 was focused on creating DynamoDB tables in AWS.

The objective was to **create a DynamoDB table using Terraform**.

**Requirements:**

- The table name should be `devops-users`;
- The primary key should be `devops_id` (String);
- The table should use `PAY_PER_REQUEST` billing mode.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what DynamoDB is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is DynamoDB?

DynamoDB is a fully managed, serverless NoSQL database service provided by AWS.

It is designed to deliver fast and predictable performance with seamless scalability.

DynamoDB is ideal for applications that require low-latency data access, such as web, mobile, gaming, ad tech, IoT, and other high-traffic applications.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_iam_user` to create the AWS IAM user.

**Complete Configuration:**

```hcl
resource "aws_dynamodb_table" "table" {
  name           = "devops-users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "devops_id"

  attribute {
    name = "devops_id"
    type = "S"
  }
  tags = {
    Name        = "devops-users"
  }
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

### 1. Check if the DynamoDB table was created on AWS

We can check if the table was created by looking for it's ARN:

```bash
terraform state show aws_dynamodb_table.table | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:dynamodb:us-east-1:000000000000:table/devops-users"
```

### 2. Check if the primary key is `devops_id`of type string

We can check if the primary key is `devops_id` by looking for the table's `hash_key`:

```bash
terraform state show aws_dynamodb_table.table | grep "hash_key"
```

Expected output:

```bash
hash_key = "devops_id"
```

We can check if the primary key is of type string by looking for the table's attributes:

```bash
terraform state show aws_dynamodb_table.table | grep -A 3 "attribute {"
```

Expected output:

```bash
attribute {
    name = "devops_id"
    type = "S"
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!