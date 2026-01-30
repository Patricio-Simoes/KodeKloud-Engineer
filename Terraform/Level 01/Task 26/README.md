---
date: 30-01-2026
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS EC2
  - AWS Elastic IPs
---
# README

Task number 26 was focused on AWS Elastic IPs.

The objective was to **attach an Elastic IP to an EC2 instance using Terraform**.

**Requirements:**

- There is an instance named `nautilus-ec2` and an elastic-ip named `nautilus-ec2-eip`;
- Attach the `nautilus-ec2-eip` elastic-ip to the `nautilus-ec2` instance using Terraform only.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Recap what an AWS EC2 is and why it is used;
2. Recap what an AWS Elastic IP is and why it is used;
3. Understand on Elastic IPs are attached to EC2 instances;
4. Write the Terraform configuration to create the resources;
5. Initialize and apply the Terraform workflow to create the infrastructure;
6. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS EC2 instance? (A recap from previous tasks)

An EC2 instance (short for Elastic Compute Cloud instance) in AWS (Amazon Web Services) is essentially a virtual server that runs in Amazon’s cloud.

> [!summary] In Short
> An EC2 instance is a VM that runs on the AWS cloud.

### 2. What Exactly is an AWS Elastic IP? (A recap from previous tasks)

An AWS Elastic IP (EIP) is a **static, public IPv4 address** designed for dynamic cloud computing in AWS. 

Unlike regular public IPs that are assigned to an instance temporarily and can change when the instance stops or restarts, **an Elastic IP remains yours until you explicitly release it**.

> [!summary] In Short
> An Elastic IP is a public ip that you own.

### 3. How are Elastic IPs attached to EC2 Instances using Terraform?

After created, an elastic IP can be attached by making use of the `aws_eip_association` resource.

### 4. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_eip` to create an Elastic IP in AWS;
- `aws_instance` to create an EC2 in AWS;
- `aws_eip_association` to associate and disassociate Elastic IPs from AWS Instances and Network Interfaces.

**Complete Configuration:**

```hcl
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-f57221523116f6408"
  vpc_security_group_ids = [
    "sg-916806551205c871a"
  ]

  tags = {
    Name = "nautilus-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  tags = {
    Name = "nautilus-ec2-eip"
  }
}

# Attach Elastic IP to EC2
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2_eip.id
}
```

### 5. Terraform Workflow

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

### 1. Check if the EC2 has the Elastic IP attached

We can check if the instance was changed by looking at the `aws_eip_association`resource on the state file:

```bash
terraform state show aws_eip_association.eip_assoc
```

Expected output:

```bash
# aws_eip_association.eip_assoc:
resource "aws_eip_association" "eip_assoc" {
    allocation_id        = "eipalloc-e7e2d54ace4d2968b"
    id                   = "eipassoc-dda7d2ba8cba43be6"
    instance_id          = "i-bdc46894d1e8c2837"
    network_interface_id = "eni-e0de8f21b74c8dfde"
    private_ip_address   = "172.31.0.4"
    public_ip            = "127.245.74.6"
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!