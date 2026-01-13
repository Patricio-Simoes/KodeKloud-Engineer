---
date: "2025-11-13"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS EC2
---
# README

Task number 7 was focused on AWS EC2 instances.

The objective was to **create an EC2 instance in AWS using Terraform**.

**Requirements:**

- Create an EC2 instance named **`nautilus-ec2`**;
- The AMI should be Amazon Linux `**ami-0c101f26f147fa7fd**`;
- The instance type should be `t2.micro`;
- A new RSA key names `nautilus-kp` should be created;
- The default security group should be attached.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS EC2 is and why it is used.
2. Recap what an AWS VPC & Key Pair are and why they are used.
3. Write the Terraform configuration to create the resources.
4. Initialize and apply the Terraform workflow to create the infrastructure.
5. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS EC2 instance?

An EC2 instance (short for Elastic Compute Cloud instance) in AWS (Amazon Web Services) is essentially a virtual server that runs in Amazon’s cloud.

> [!summary] In Short
> An EC2 instance is a VM that runs on the AWS cloud.

### 2. What Exactly are AWS VPCs & Key pairs? (A recap from previous tasks)

An AWS VPC (Virtual Private Cloud) is a **virtual network** dedicated to an AWS account.

An **AWS key pair** is a set of cryptographic credentials used for authentication and secure communication with AWS services—most commonly when connecting to EC2 instances via SSH.

### 3. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_instance` to create an EC2 in AWS.
- `tls_private_key` to create a private key using Terraform.
- `aws_key_pair` to create a public key that pairs with the private key created.

There is also a new `data` block introduced in this task. This block is used to **retrieve** data from existing resources. **It does not modify** them in any way.

Below is the complete configuration that meets the requirements:

data.tf

```hcl
# Get information about the default VPC.
data "aws_vpc" "vpc" {
  default = true
}

# Get information about the default security group in that VPC.
data "aws_security_group" "sg" {
  name   = "default"
  vpc_id = data.aws_vpc.vpc.id
}
```

main.tf

```hcl
resource "aws_instance" "nautilus_ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"

  key_name = aws_key_pair.nautilus_kp.key_name

  vpc_security_group_ids = [data.aws_security_group.sg.id]

  tags = {
    Name = "nautilus-ec2"
  }
}

resource "tls_private_key" "nautilus_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp"
  public_key = tls_private_key.nautilus_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.nautilus_key.private_key_pem
  filename        = "/home/bob/xfusion-kp.pem"
  file_permission = "0400"
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

### 1. Check if the EC2 was created on AWS

Not only should the EC2 be present, the key pair and security group should also be present and attached to the EC2.

```bash
terraform state show aws_instance.nautilus_ec2
```

Expected output:

```bash
resource "aws_instance" "nautilus_ec2" {
    ami                                  = "ami-0c101f26f147fa7fd"
    arn                                  = "arn:aws:ec2:us-east-1::instance/i-6d4e1b5c8ae65e4fa"
    associate_public_ip_address          = true
    availability_zone                    = "us-east-1a"
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    get_password_data                    = false
    hibernation                          = false
    host_id                              = null
    iam_instance_profile                 = null
    id                                   = "i-6d4e1b5c8ae65e4fa"
    instance_initiated_shutdown_behavior = "stop"
    instance_lifecycle                   = null
    instance_state                       = "running"
    instance_type                        = "t2.micro"
    ipv6_address_count                   = 0
    ipv6_addresses                       = []
    key_name                             = "nautilus-kp"
    monitoring                           = false
    outpost_arn                          = null
    password_data                        = null
    placement_group                      = null
    placement_partition_number           = 0
    primary_network_interface_id         = "eni-a7a9b3428547538cf"
    private_dns                          = "ip-10-220-66-151.ec2.internal"
    private_ip                           = "10.220.66.151"
    public_dns                           = "ec2-54-214-254-254.compute-1.amazonaws.com"
    public_ip                            = "54.214.254.254"
    secondary_private_ips                = []
    security_groups                      = [
        "default",
    ]
    source_dest_check                    = true
    spot_instance_request_id             = null
    subnet_id                            = "subnet-7ee4e9b3813ac60e5"
    tags                                 = {
        "Name" = "nautilus-ec2"
    }
    tags_all                             = {
        "Name" = "nautilus-ec2"
    }
    tenancy                              = "default"
    user_data_replace_on_change          = false
    vpc_security_group_ids               = [
        "sg-e0d8771a91a739809",
    ]

    metadata_options {
        http_endpoint               = "enabled"
        http_protocol_ipv6          = "disabled"
        http_put_response_hop_limit = 1
        http_tokens                 = "optional"
        instance_metadata_tags      = "disabled"
    }

    root_block_device {
        delete_on_termination = true
        device_name           = "/dev/sda1"
        encrypted             = false
        iops                  = 0
        kms_key_id            = null
        tags                  = {}
        tags_all              = {}
        throughput            = 0
        volume_id             = "vol-15230e02552999ae6"
        volume_size           = 8
        volume_type           = "gp2"
    }
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!