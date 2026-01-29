---
date: 29-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - OpenSearch
---
# README

Task number 23 was focused on OpenSearch.

The objective was to **to set up an Amazon OpenSearch Service domain using Terraform**.

**Requirements:**

- The domain name should be `nautilus-es`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what Amazon OpenSearch is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is Amazon OpenSearch?

OpenSearch is an open-source search and analytics engine. 

It helps us store large amounts of data and then search, filter, and analyze it really fast.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_opensearch_domain` to create the OpenSearch domain in AWS;

**Complete Configuration:**

```hcl
resource "aws_opensearch_domain" "domain" {
  domain_name = "nautilus-es"
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

### 1. Check if the OpenSearch domain was created on AWS

We can check if the domain was created by looking for it's ARN:

```bash
terraform state show aws_opensearch_domain.domain | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:es:us-east-1:000000000000:domain/nautilus-es"
id  = "arn:aws:es:us-east-1:000000000000:domain/nautilus-es"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!