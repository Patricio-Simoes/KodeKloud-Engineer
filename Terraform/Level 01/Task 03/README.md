---
date: 2025-10-29
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS VPCs
---
# Task 03 - AWS VPC Creation with Terraform

Task number 3 was focused on AWS VPCs.

The objective was to **create a VPC in AWS using Terraform**.

**Requirements:**

- Create a VPC named **`nautilus-vpc`**;
- Deploy in region **`us-east-1`**;
- Use any IPv4 CIDR block.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS VPC is and why it is used.
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
resource "aws_vpc" "nautilus-vpc" {
	cidr_block = "10.0.0.0/16"
	
	tags = {
		# The Name tag defines the name of the VPC in AWS.
		Name = "nautilus-vpc"
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

Expected Output:

```json
{
	"OwnerId": "000000000000",
	"InstanceTenancy": "default",
	"CidrBlockAssociationSet": [
		{
			"AssociationId": "vpc-cidr-assoc-0af674a6bfc011171",
			"CidrBlock": "10.0.0.0/16",
			"CidrBlockState": {
				"State": "associated"
			}
		}
	],
	"IsDefault": false,
	"Tags": [
		{
			"Key": "Name",
			"Value": "nautilus-vpc"
		}
	],
	"BlockPublicAccessStates": {
		"InternetGatewayBlockMode": "off"
	},
	"VpcId": "vpc-09e72a17527ff94c3",
	"State": "available",
	"CidrBlock": "10.0.0.0/16",
	"DhcpOptionsId": "dopt-06bda115b992b5e2b"
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!