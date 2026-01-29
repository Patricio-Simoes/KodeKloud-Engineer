---
date: 26-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - SSM Parameters
---
# README

Task number 20 was focused on SSM Parameters in AWS.

The objective was to **create an SSM Parameter using Terraform**.

**Requirements:**

- The name of the parameter should be `devops-ssm-parameter`;
- Set the parameter type to `String`;
- Set the parameter value to `devops-value`;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what SSM Parameters are and why they are used;
2. Write the Terraform configuration to create the resources.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly are SSM Parameters?

AWS Systems Manager, (SSM), Parameters are a feature that allows us to **store and manage configuration data, secrets, and other information** in a centralized, secure, and scalable way.

SSM Parameters are essentially **key-value pairs** that we can reference in our applications, scripts, and AWS services.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_ssm_parameter` to create the SSM Parameter.

**Complete Configuration:**

```hcl
resource "aws_ssm_parameter" "devops_ssm_parameter" {
  name  = "devops-ssm-parameter"
  type  = "String"
  value = "devops-value"
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

### 1. Check if the parameter was created on AWS

We can check if the SSM parameter was created by looking for it's ARN:

```bash
terraform state show aws_ssm_parameter.devops_ssm_parameter | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:ssm:us-east-1:000000000000:parameter/devops-ssm-parameter"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!