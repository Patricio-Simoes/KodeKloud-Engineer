---
date: "2025-11-14"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS AMIs
---
# README

Task number 8 was focused on creating AWS AMIs.

The objective was to **create an AMI from an existing EC2 instance in AWS using Terraform**.

**Requirements:**

- Create an AMI from an existing EC2 instance named `devops-ec2`;
- The name of the AMI should be `devops-ec2-ami`;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS AMI is and why it is used.
2. Recap what an AWS EC2 instance is and why they are used.
3. Write the Terraform configuration to create the resources.
4. Initialize and apply the Terraform workflow to create the infrastructure.
5. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS AMI?

An AWS AMI (Amazon Machine Image) is a template used to launch EC2 instances.

When launching an EC2 from an AMI, all dependencies come pre-installed making boot time is much shorter and required configuratios already included.

### 2. What Exactly is an AWS EC2 instance?

An EC2 instance (short for Elastic Compute Cloud instance) in AWS (Amazon Web Services) is essentially a virtual server that runs in Amazon’s cloud.

### 3. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_ami_from_instance` to create an AMI from an existing EC2 instance in AWS.

**Note:** The EC2 instance was already provisioned.

Below is the complete configuration that meets the requirements:

```hcl
# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-0692b32ff0bfd6296"
  ]

  tags = {
    Name = "devops-ec2"
  }
}

resource "aws_ami_from_instance" "devops_ec2_ami" {
  name               = "devops-ec2-ami"
  source_instance_id = aws_instance.ec2.id
}
```

### 4. Terraform Workflow

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

### 1. Check if the AMI was created on AWS

```bash
terraform state show aws_ami_from_instance.devops_ec2_ami
```

Expected output:

```bash
resource "aws_ami_from_instance" "devops_ec2_ami" {
    architecture         = "x86_64"
    arn                  = "arn:aws:ec2:us-east-1::image/ami-1177eff5edc706cf9"
    boot_mode            = "uefi"
    deprecation_time     = null
    description          = null
    ena_support          = false
    hypervisor           = null
    id                   = "ami-1177eff5edc706cf9"
    image_location       = null
    image_owner_alias    = null
    image_type           = "machine"
    imds_support         = null
    kernel_id            = null
    manage_ebs_snapshots = true
    name                 = "devops-ec2-ami"
    owner_id             = "000000000000"
    platform             = null
    platform_details     = null
    public               = false
    ramdisk_id           = null
    root_device_name     = "/dev/sda1"
    root_snapshot_id     = "snap-a33c8480e2433ee86"
    source_instance_id   = "i-cc95fccd17c98edce"
    sriov_net_support    = null
    tags_all             = {}
    tpm_support          = null
    usage_operation      = null
    virtualization_type  = "paravirtual"

    ebs_block_device {
        delete_on_termination = false
        device_name           = "/dev/sda1"
        encrypted             = false
        iops                  = 0
        outpost_arn           = null
        snapshot_id           = "snap-a33c8480e2433ee86"
        throughput            = 0
        volume_size           = 15
        volume_type           = "standard"
    }
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!