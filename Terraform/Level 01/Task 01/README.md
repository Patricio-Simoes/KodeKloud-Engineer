---
date: 2025-10-29
tags:
  - KodeKloud
  - Terraform
topics: AWS Key Pairs
---
# Task 01 - Creating an AWS Key Pair

This task marked the beginning of my journey in KodeKloud. It was a simple, but yet challenging exercise for someone with little prior experience in Infrastructure as Code (IaC) tools.

The objective was to **create an AWS key pair using Terraform**.

**Requirements:**

- The key pair must be named **`xfusion-kp`**;
- The key type must be **`rsa`**;
- The private key file should be saved at **`/home/bob/xfusion-kp.pem`**;
- The Terraform working directory is **`/home/bob/terraform`**.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS key pair is and why it is used.
2. Write the Terraform configuration to generate and register the key pair.
3. Initialize and apply the Terraform workflow to create the infrastructure.
4. Verify that the key pair was created successfully on AWS.

### 1. What Exactly is an AWS Key Pair?

An **AWS key pair** is a set of cryptographic credentials used for authentication and secure communication with AWS services—most commonly when connecting to EC2 instances via SSH.

Each key pair consists of:

- **Private Key**  
    Stored securely by the user and used to decrypt data. It should never be shared or uploaded to AWS.
- **Public Key**  
    Stored by AWS and used to encrypt data. When an EC2 instance is launched, AWS places the public key on the instance so that users possessing the private key can securely connect via SSH.

> [!summary] In Short
> The **private key** stays with you. The **public key** lives in AWS.

### 2. The Terraform Solution

Terraform provides two main resources for this task:

- `tls_private_key` to generate an RSA key locally.
- `aws_key_pair` to register the public key with AWS.

Below is the complete configuration that meets the requirements:

```hcl
# Generate the RSA private key locally.
resource "tls_private_key" "xfusion_key" {
  algorithm = "RSA"
  rsa_bits     = 4096
}

# Create the AWS key pair using the public key from the TLS resource.
resource "aws_key_pair" "xfusion_kp" {
  key_name   = "xfusion-kp"
  public_key  = tls_private_key.xfusion_key.public_key_openssh
}

# Save the generated private key locally.
resource "local_file" "private_key_pem" {
  content               = tls_private_key.xfusion_key.private_key_pem
  filename             = "/home/bob/xfusion-kp.pem"
  file_permission = "0400"
}
```

This setup ensures the key pair is generated securely, the public key is uploaded to AWS, and the private key is saved locally with strict permissions.

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

### 1. Check if the private key was created locally

```bash
ls -l /home/bob/nautilus-kp.pem
```

Expected Output:

```bash
-r-------- 1 bob bob  3243 out 29 07:22 xfusion-kp.pem
```

### 2. Check if the public key was created on AWS

```bash
aws ec2 describe-key-pairs
```

Expected Output:

```json
{
   "KeyPairs": [  
       {  
           "KeyPairId": "key-0868c3d05a6ab6a35",  
           "KeyType": "rsa",  
           "Tags": [],  
           "CreateTime": "2025-10-29T07:22:10.004000+00:00",  
           "KeyName": "xfusion-kp",  
           "KeyFingerprint": "25:a3:01:3c:5d:6f:56:be:cc:b2:c1:8f:03:e8:9e:57"  
       }  
   ]  
}
```

## Troubleshooting

Surprisingly, no issues occurred during this task!