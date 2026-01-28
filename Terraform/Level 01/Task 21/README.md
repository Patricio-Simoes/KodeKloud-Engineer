---
date: 28-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - CloudWatch
---
# README

Task number 21 was focused on AWS CloudWatch.

The objective was to **create a CloudWatch log group and log stream using Terraform**

**Requirements:**

- The log group name should be `nautilus-log-group`;
- The log stream name should be `nautilus-log-stream`;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what CloudWatch log groups & log streams  are and why they are used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly are CloudWatch log groups & log streams?

A CloudWatch log group is a container that holds related log streams. It is like a "folder" where we organize logs based on a common purpose, such as an application, service, or resource (e.g., an EC2 instance or Lambda function).

A log stream is a sequence of log events (individual log entries) within a log group. It represents a specific source of logs, such as a single instance of an application or a specific process.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_cloudwatch_log_group` to create the log group in AWS;
- `aws_cloudwatch_log_stream` to create the log stream in AWS;

**Complete Configuration:**

```hcl
resource "aws_cloudwatch_log_group" "log_group" {
  name = "nautilus-log-group"
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "nautilus-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
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

### 1. Check if the CloudWatch log group was created on AWS

We can check if the log group was created by looking for it's ARN:

```bash
terraform state show aws_cloudwatch_log_group.log_group | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:logs:us-east-1:000000000000:log-group:nautilus-log-group"
```

### 2. Check if the CloudWatch log stream was created on AWS

We can check if the log stream was created by looking for it's ARN:

```bash
terraform state show aws_cloudwatch_log_stream.log_stream | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:logs:us-east-1:000000000000:log-group:nautilus-log-group:log-stream:nautilus-log-stream"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!