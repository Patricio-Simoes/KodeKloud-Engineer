---
date: 31-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS Elastic IPs
---
# Task 37 - Elastic IP Variable Setup Using Terraform

Task number 37 was focused on AWS Elastic IPs.

The objective was to **create an Elastic IPs using Terraform**.

**Requirements:**

- The Elastic IP name `datacenter-eip` should be stored in a variable named `KKE_eip`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what an Elastic IP is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS Elastic IP? (A recap from previous tasks)

An AWS Elastic IP (EIP) is a **static, public IPv4 address** designed for dynamic cloud computing in AWS.

Unlike regular public IPs that are assigned to an instance temporarily and can change when the instance stops or restarts, **an Elastic IP remains yours until you explicitly release it**.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_eip` to create a Elastic IP in AWS.
- `variable` block, to specify Terraform variables.

**Complete Configuration:**

```hcl
resource "aws_eip" "this" {
  tags = {
    Name = var.KKE_eip
  }
}

variable "KKE_eip" {
  type        = string
  description = "Name of the Elastic IP"
  default     = "datacenter-eip"
}
```

### 3. Terraform Workflow

Once this is done, the standard Terraform workflow applies:

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

### 1. Check if the Elastic IP was created

We can check if the Elastic IP was created with the AWS CLI tool:

```bash
aws ec2 describe-addresses
```

Expected output:

```bash
{
    "Addresses": [
        {
            "AllocationId": "eipalloc-8ae77cb6ea7b4e331",
            "Domain": "vpc",
            "NetworkInterfaceId": "",
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "datacenter-eip"
                }
            ],
            "InstanceId": "",
            "PublicIp": "127.142.125.239"
        }
    ]
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!