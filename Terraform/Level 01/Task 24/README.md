---
date: 29-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS Secrets Manager
---
# README

Task number 24 was focused on AWS Secrets Manager.

The objective was to **to create an AWS Secrets Manager secret using Terraform**.

**Requirements:**

- The secret name should be `devops-secret`;
- The secret value should contain a key-value pair with `username`: `admin` and `password`: `Namin123`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what AWS Secrets Manager is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is AWS Secrets Manager?

AWS Secrets Manager is a service that securely stores and manages sensitive information so that applications don’t have to hard-code them.

Instead of putting secrets directly in the app or config files, we store them in AWS Secrets Manager and the app asks AWS for the at runtime.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_secretsmanager_secret` to create the secret in AWS Secrets Manager;
- `aws_secretsmanager_secret_version` to manage AWS Secrets Manager secret version including its secret value.

**Complete Configuration:**

```hcl
resource "aws_secretsmanager_secret" "devops_secret" {
  name = "devops-secret"
}

resource "aws_secretsmanager_secret_version" "devops_secret_value" {
  secret_id = aws_secretsmanager_secret.devops_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "Namin123"
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

### 1. Check if the secret was created on AWS

We can check if the secret was created by looking for it's ARN:

```bash
terraform state show aws_secretsmanager_secret.devops_secret | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:secretsmanager:us-east-1:000000000000:secret:devops-secret-CxTwpG"
id  = "arn:aws:secretsmanager:us-east-1:000000000000:secret:devops-secret-CxTwpG"
```

### 2. Check if the secret was populated in AWS

We can check if the secret was created by looking for it's ARN:

```bash
terraform state show aws_secretsmanager_secret_version.devops_secret_value | grep "arn"
```

Expected output:

```bash
arn       = "arn:aws:secretsmanager:us-east-1:000000000000:secret:devops-secret-CxTwpG"
secret_id = "arn:aws:secretsmanager:us-east-1:000000000000:secret:devops-secret-CxTwpG"
```

Since these are sensitive fields, they will not show up in the state file:

```bash
terraform state show aws_secretsmanager_secret_version.devops_secret_value | grep "secret_string"
```

Expected output:

```bash
secret_string    = (sensitive value)
```

## Troubleshooting

Surprisingly, no issues occurred during this task!