---
date: 26-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - Kinesis
---
# README

Task number 18 was focused on Kinesis data streams.

The objective was to **create a kinesis stream using Terraform**.

**Requirements:**

- The stream should be named `devops-stream`;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what Kinesis data streams are and why they is used;
2. Write the Terraform configuration to create the resources.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly are Kinesis data streams?

Kinesis Data Streams is a scalable and durable **real-time data streaming service** provided by AWS.

It enables us to **collect, process, and analyze streaming data** from hundreds of thousands of sources, such as application logs, website clickstreams, IoT device telemetry, financial transactions, and social media feeds.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_kinesis_stream` to create the data stream;

**Complete Configuration:**

```hcl
resource "aws_kinesis_stream" "devops_stream" {
  name = "devops-stream"
  
  stream_mode_details {
    stream_mode = "ON_DEMAND"
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

### 1. Check if the stream was created on AWS

We can check if the data stream was created by looking for it's ARN:

```bash
terraform state show aws_kinesis_stream.devops_stream | grep "arn"
```

Expected output:

```bash
arn = "arn:aws:kinesis:us-east-1:000000000000:stream/devops-stream"
id = "arn:aws:kinesis:us-east-1:000000000000:stream/devops-stream"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!