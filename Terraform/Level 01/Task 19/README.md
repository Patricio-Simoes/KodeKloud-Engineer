---
date: 26-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - SNS Topics
---
# README

Task number 19 was focused on AWS SNS Topics.

The objective was to **create an SNS topic using Terraform**.

**Requirements:**

- The topic name should be `devops-notifications`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what AWS SNS is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly are SNS Topics?

Amazon Simple Notification Service, (SNS), Topics are a is a fully managed pub/sub, (publish-subscribe), messaging service.

SNS Topics act as a **communication channel** that allows us to send messages (notifications) to **multiple subscribers** simultaneously.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_sns_topic` to create the SNS topic;

**Complete Configuration:**

```hcl
resource "aws_sns_topic" "devops_notifications" {
  name = "devops-notifications"
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

### 1. Check if the topic was created on AWS

We can check if the SNS topic was created by looking for it's ARN:

```bash
terraform state show aws_sns_topic.devops_notifications | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:sns:us-east-1:000000000000:devops-notifications"
id  = "arn:aws:sns:us-east-1:000000000000:devops-notifications"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!