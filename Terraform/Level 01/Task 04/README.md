---
date: 2025-10-29
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS VPCs
---
# Task 04 - AWS VPC Creation with Terraform

Task number 4 was yet again focused on AWS VPCs. But this time, there was a mandatory IPv4 CIDR block declared.

The objective was to **create a VPC in AWS with a specific CIDR using Terraform**.

Overall, this task was the same as the previous one, with the exception that this one had a mandatory CIDR declared.

**Requirements:**

- Create a VPC named **`datacenter-vpc`**;
- Deploy in region **`us-east-1`**;
- Use the **`192.168.0.0/24`** IPv4 CIDR block;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what an AWS VPC is and why it is used.
2. Write the Terraform configuration to create the VPC.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the VPC was created successfully on AWS.

### 1. What Exactly is an AWS VPC?

An AWS VPC (Virtual Private Cloud) is a **virtual network** dedicated to an AWS account.

It enables you to launch AWS resources in a logically isolated environment, giving you complete control over your network settings. This includes defining your IP address range, creating subnets, and configuring route tables and network gateways.

> [!summary] In Short
> A VPC is a network that lives inside AWS.

### 2. The Terraform Solution

Terraform provides a resource for this task:

- `aws_vpc` to create a VPC in AWS.

Below is the complete configuration that meets the requirements:

```hcl
resource "aws_vpc" "datacenter-vpc" {
	cidr_block = "192.168.0.0/24"
	
	tags = {
		# The Name tag defines the name of the VPC in AWS.
		Name = "datacenter-vpc"
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

### 1. Check if the VPC was created on AWS

```bash
aws ec2 describe-vpcs --region=us-east-1
```

Expected output:

```json
{
	"OwnerId": "000000000000",
	"InstanceTenancy": "default",
	"Ipv6CidrBlockAssociationSet": [],
	"CidrBlockAssociationSet": [
		{
			"AssociationId": "vpc-cidr-assoc-134c5042c1578ffe3",
			"CidrBlock": "192.168.0.0/24",
			"CidrBlockState": {
				"State": "associated"
			}
		}
	],
	"IsDefault": false,
	"Tags": [
		{
			"Key": "Name",
			"Value": "datacenter-vpc"
		}
	],
	"VpcId": "vpc-cb546a507056f3f08",
	"State": "available",
	"CidrBlock": "192.168.0.0/24",
	"DhcpOptionsId": "default"
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!