---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS EC2
---
# Task 30 - Delete EC2 Instance Using Terraform

Task number 30 was focused on AWS EC2 instances.

The objective was to **delete an EC2 instance using Terraform**.

**Requirements:**

- Delete the ec2 instance named `xfusion-ec2`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what AWS EC2 is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS EC2 instance? (A recap from previous tasks)

An EC2 instance (short for Elastic Compute Cloud instance) in AWS (Amazon Web Services) is essentially a virtual server that runs in Amazon’s cloud.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_instance` to create an EC2 instance in AWS.

**Complete Configuration:**

```hcl
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-1df24021c7135b633"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
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

### 1. Check if the EC2 instance was terminated

We can check if the EC2 instance was deleted by using the AWS CLI tool:

```bash
aws ec2 describe-instances | grep -A 3 "State"
```

Expected output:

```bash
"State": {
  "Code": 48,
  "Name": "terminated"
},
```
## Troubleshooting

Surprisingly, no issues occurred during this task!