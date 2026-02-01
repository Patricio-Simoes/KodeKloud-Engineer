---
date: 2026-01-31
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS VPCs
  - AWS Subnets
---

# Task 01 - Create VPC and Subnet Using Terraform

Task number 1 was focused on AWS VPCs & Subnets.

The objective was to **create a security group in AWS using Terraform**.

**Requirements:**

- Create a VPC named `nautilus-vpc`; 
- Create a Subnet named `nautilus-subnet`; 
- Ensure the Subnet uses the `depends_on` argument to explicitly depend on the VPC resource;
- Define the following variables:
  - `KKE_VPC_NAME` for the VPC name;
  - `KKE_SUBNET_NAME` for the Subnet name.
- Use terraform.tfvars to input the names of the VPC and subnet.
- In outputs.tf, output the following:
  - `kke_vpc_name`: The name of the VPC; 
  - `kke_subnet_name`: The name of the Subnet.

### Terraform Solution

**main.tf**
```hcl
resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/24"

  tags = {
    Name = var.KKE_VPC_NAME
  }
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.KKE_SUBNET_NAME
  }

  depends_on = [aws_vpc.this]
}
```

**variables.tf**
```bash
variable "KKE_VPC_NAME" {
  type        = string
  description = "Name of the VPC"
  default     = ""
}

variable "KKE_SUBNET_NAME" {
  type        = string
  description = "Name of the Subnet"
  default     = ""
}
```

**outputs.tf**
```bash
output "kke_vpc_name" {
  value = var.KKE_VPC_NAME
}

output "kke_subnet_name" {
  value = var.KKE_SUBNET_NAME
}
```

**terraform.tfvars**
```bash
KKE_VPC_NAME    = "nautilus-vpc"
KKE_SUBNET_NAME = "nautilus-subnet"
```