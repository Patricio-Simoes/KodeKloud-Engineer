---
date: 2025-10-29
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS Security Groups
---
# Task 02 - AWS Security Group Creation with Terraform

Task number 2 was focused on AWS Security Groups.

The objective was to **create a security group in AWS using Terraform**.

**Requirements:**

- The name of the security group must be **`datacenter-sg`**;
- The description must be **`Security group for Nautilus App Servers`**;
- Add an inbound rule of type **HTTP**, with port range **80**, and source CIDR range **0.0.0.0/0**;
- Add another inbound rule of type **SSH**, with port range **22**, and source CIDR range **0.0.0.0/0**;
- Ensure the security group is created in the **us-east-1** region;
- The Terraform working directory is **`/home/bob/terraform`**;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS security group is and why it is used.
2. Write the Terraform configuration to generate and register the security group.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the security group was created successfully on AWS.

### 1. What Exactly is an AWS Security Group?

An AWS Security Group is a **virtual firewall that controls inbound and outbound traffic** to AWS resources.

It enables you to secure your cloud environment by defining rules that specify what traffic is allowed or denied.

### 2. The Terraform Solution

Terraform provides two main resources for this task:

- `aws_security_group` to create a new security group in AWS.
- `aws_vpc_security_group_ingress_rule` to register and attach ingress rules to a security group.

Below is the complete configuration that meets the requirements:

```hcl
resource "aws_security_group" "datacenter-sg" {
	name = "datacenter-sg"
	description = "Security group for Nautilus App Servers"
	region = "us-east-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
	# The security_group_id binds the rule to the security group.
	security_group_id = aws_security_group.datacenter-sg.id
	cidr_ipv4 = "0.0.0.0/0"
	from_port = 80
	# HTTP uses TCP, therefore, ip_protocol = "tcp".
	ip_protocol = "tcp"
	to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
	# The security_group_id binds the rule to the security group.
	security_group_id = aws_security_group.datacenter-sg.id
	cidr_ipv4 = "0.0.0.0/0"
	from_port = 22
	# HTTP uses TCP, therefore, ip_protocol = "ssh".
	ip_protocol = "tcp"
	to_port = 22
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

### 1. Check if the security group was created on AWS

```bash
aws ec2 describe-security-groups --region us-east-1
```

Expected Output:

```json
{  
           "GroupId": "sg-4e8fe128ec205fe2d",  
           "IpPermissionsEgress": [],  
           "VpcId": "vpc-740a6d99231fb0e56",  
           "SecurityGroupArn": "arn:aws:ec2:us-east-1:000000000000:security-group/sg-4e8fe128ec205fe2d",  
           "OwnerId": "000000000000",  
           "GroupName": "datacenter-sg",  
           "Description": "Security group for Nautilus App Servers",  
           "IpPermissions": [  
               {  
                   "IpProtocol": "tcp",  
                   "FromPort": 80,  
                   "ToPort": 80,  
                   "UserIdGroupPairs": [],  
                   "IpRanges": [  
                       {  
                           "CidrIp": "0.0.0.0/0"  
                       }  
                   ],  
                   "Ipv6Ranges": [],  
                   "PrefixListIds": []  
               },  
               {  
                   "IpProtocol": "tcp",  
                   "FromPort": 22,  
                   "ToPort": 22,  
                   "UserIdGroupPairs": [],  
                   "IpRanges": [  
                       {  
                           "CidrIp": "0.0.0.0/0"  
                       }  
                   ],  
                   "Ipv6Ranges": [],  
                   "PrefixListIds": []  
               }  
           ]  
       }
```

## Troubleshooting

Surprisingly, no issues occurred during this task!