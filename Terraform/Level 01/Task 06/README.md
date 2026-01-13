---
date: "2025-11-09"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS Elastic IPs
---
# README

Task number 6 was focused on AWS Elastic IPs.

The objective was to **create an Elastic IP in AWS using Terraform**.

**Requirements:**

- Create an Elastic IP named **`devops-eip`**.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS Elastic IP is and why it is used.
2. Write the Terraform configuration to create the Elastic IP.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the Elastic IP was created successfully on AWS.

### 1. What Exactly is an AWS Elastic IP?

An AWS Elastic IP (EIP) is a **static, public IPv4 address** designed for dynamic cloud computing in AWS. 

Unlike regular public IPs that are assigned to an instance temporarily and can change when the instance stops or restarts, **an Elastic IP remains yours until you explicitly release it**.

> [!summary] In Short
> An Elastic IP is a public ip that you own.

### 2. The Terraform Solution

Terraform provides a resource for this task:

- `aws_eip` to create an Elastic IP in AWS.

Below is the complete configuration that meets the requirements:

```hcl
resource "aws_eip" "xfusion-eip" {
  domain = "vpc"
  tags = {
    Name = "xfusion-eip"
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

### 1. Check if the Elastic IP was created on AWS

```bash
terraform state show aws_eip.xfusion-eip
```

Expected output:

```bash
resource "aws_eip" "xfusion-eip" {
    allocation_id            = "eipalloc-c2e7346ebc2faa3a9"
    arn                      = "arn:aws:ec2:us-east-1::elastic-ip/eipalloc-c2e7346ebc2faa3a9"
    association_id           = null
    carrier_ip               = null
    customer_owned_ip        = null
    customer_owned_ipv4_pool = null
    domain                   = "vpc"
    id                       = "eipalloc-c2e7346ebc2faa3a9"
    instance                 = null
    network_border_group     = null
    network_interface        = null
    private_ip               = null
    ptr_record               = null
    public_dns               = "ec2-127-93-146-202.compute-1.amazonaws.com"
    public_ip                = "127.93.146.202"
    public_ipv4_pool         = null
    tags                     = {
        "Name" = "xfusion-eip"
    }
    tags_all                 = {
        "Name" = "xfusion-eip"
    }
    vpc                      = true
}
```

## Troubleshooting

My first attempt st this task failed, after thinking for a while, i found out that, i forgot to include the `Name` tag, and therefore, the eip `devops-eip` did not exist!