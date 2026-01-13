---
date: "2025-10-30"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS VPCs
---
# README

Task number 5 was yet again focused on AWS VPCs. The change this time, was that, the VPC should have a IPv6 address associated.

The objective was to **create a VPC in AWS with an IPv6 associated address using Terraform**.

**Requirements:**

- Create a VPC named **`nautilus-vpc`**;
- Deploy in region **`us-east-1`**;
- Associate an IPv6 address to the VPC.

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
resource "aws_vpc" "nautilus-vpc" {
	cidr_block = "192.168.0.0/24"
	assign_generated_ipv6_cidr_block = true

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
terraform state show aws_vpc.nautilus-vpc
```

Expected output:

```bash
resource "aws_vpc" "nautilus-vpc" {
	arn = "arn:aws:ec2:us-east-1:000000000000:vpc/vpc-1e62e82acd6d27899"
	assign_generated_ipv6_cidr_block = true
	cidr_block = "192.168.0.0/24"
	default_network_acl_id = "acl-a0106031634b84a78"
	default_route_table_id = "rtb-9a2b4851e894ba6a2"
	default_security_group_id = "sg-de90c2e7289ced984"
	dhcp_options_id = "default"
	enable_dns_hostnames = false
	enable_dns_support = true
	enable_network_address_usage_metrics = false
	id = "vpc-1e62e82acd6d27899"
	instance_tenancy = "default"
	ipv6_association_id = "vpc-cidr-assoc-1eaa8532dabfb5559"
	ipv6_cidr_block = "2400:6500:f6b9:7d00::/56"
	ipv6_cidr_block_network_border_group = null
	ipv6_ipam_pool_id = null
	ipv6_netmask_length = 0
	main_route_table_id = "rtb-9a2b4851e894ba6a2"
	owner_id = "000000000000"
	tags = {
		"Name" = "nautilus-vpc"
	}
	tags_all = {
		"Name" = "nautilus-vpc"
	}
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!