---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS EC2
---
# README

Task number 25 was focused on EC2 instance types.

The objective was to **to change an EC2 instance type using Terraform**.

**Requirements:**

- Change the instance type from `t2.micro` to `t2.nano` for `devops-ec2` instance using terraform;
- Make sure the EC2 instance `devops-ec2` is in running state after the change.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what an AWS EC2 is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS EC2 instance? (A recap from previous tasks)

An EC2 instance (short for Elastic Compute Cloud instance) in AWS (Amazon Web Services) is essentially a virtual server that runs in Amazon’s cloud.

> [!summary] In Short
> An EC2 instance is a VM that runs on the AWS cloud.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_instance` to create an EC2 in AWS.

**Complete Configuration:**

```hcl
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.nano"
  subnet_id     = ""
  vpc_security_group_ids = [
    "sg-99e3cf0be67820413"
  ]

  tags = {
    Name = "devops-ec2"
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

### 1. Check if the EC2 has the `t2.nano`instance type

We can check if the instance was changed by looking at the state file:

```bash
terraform state show aws_instance.ec2 | grep instance_type
```

Expected output:

```bash
instance_type = "t2.nano"
```

### 2. Check if the instance is running

We can check if the instance is running using the AWS CLI tool:

```bash
aws ec2 describe-instances --instance-ids i-caca262b3f0ccd183 | grep -A 3 '"State": {'
```

Expected output:

```bash
"State": {
  "Code": 16,
  "Name": "running"
},
```

**Note:** To get the instance id:

```bash
terraform state show aws_instance.ec2 | grep "id"
```

## Troubleshooting

Surprisingly, no issues occurred during this task!