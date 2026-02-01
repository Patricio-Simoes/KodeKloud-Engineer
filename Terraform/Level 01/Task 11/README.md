---
date: "2026-01-21"
tags:
  - KodeKloud
  - Terraform
topics:
  - AWS CloudWatch Alarms
---
# Task 11 - Create Alarm Using Terraform

Task number 11 was focused on creating AWS CloudWatch alarms.

The objective was to **create a CloudWatch alarm using Terraform**.

**Requirements:**

- Create a CloudWatch alarm named `devops-alarm`;
- The alarm should monitor CPU utilization of an EC2 instance.
- Trigger the alarm when CPU utilization exceeds 80%.
- Set the evaluation period to 5 minutes.
- Use a single evaluation period.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what an AWS CloudWatch Alarm is and why it is used;
2. Write the Terraform configuration to create the resources;
3. Initialize and apply the Terraform workflow to create the infrastructure;
4. Verify that the resources were created successfully on AWS.

### 1. What Exactly is an AWS CloudWatch Alarm?

A CloudWatch Alarm watches a single metric over a specified time period, and performs one or more actions based on the value of the metric relative to a threshold.

### 2. The Terraform Solution

Terraform provides the following resources for this task:

- `aws_cloudwatch_metric_alarm` to create the alarm in AWS;
- `aws_instance`to create the EC2 instance.

**Complete Configuration:**

```hcl
resource "aws_instance" "devops_machine" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"

  tags = {
    Name = "devops_machine"
  }
}

resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
  alarm_name          = "devops-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300 # 5 minutes in seconds.
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers when the DevOps EC2 CPU usage exceeds 80%"

  dimensions = {
    InstanceId = aws_instance.devops_machine.id
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

### 1. Check if the CloudWatch alarm was created on AWS

```bash
terraform state show aws_cloudwatch_metric_alarm.devops_alarm
```

Expected output:

```bash
# aws_cloudwatch_metric_alarm.devops_alarm:
resource "aws_cloudwatch_metric_alarm" "devops_alarm" {
    actions_enabled                       = true
    alarm_description                     = "Triggers when the DevOps EC2 CPU usage exceeds 80%"
    alarm_name                            = "devops-alarm"
    arn                                   = "arn:aws:cloudwatch:us-east-1:000000000000:alarm:devops-alarm"
    comparison_operator                   = "GreaterThanThreshold"
    datapoints_to_alarm                   = 0
    dimensions                            = {
        "InstanceId" = "i-fcb1f6fb6c18db229"
    }
    evaluate_low_sample_count_percentiles = null
    evaluation_periods                    = 1
    extended_statistic                    = null
    id                                    = "devops-alarm"
    metric_name                           = "CPUUtilization"
    namespace                             = "AWS/EC2"
    period                                = 300
    statistic                             = "Average"
    tags_all                              = {}
    threshold                             = 80
    threshold_metric_id                   = null
    treat_missing_data                    = "missing"
    unit                                  = null
}
```

**Note:** Since `InstanceId` is present as `i-fcb1f6fb6c18db229`, it is safe to assume that the EC2 was created wih no issues.

## Troubleshooting

I was a bit confused on wether or not i should be the one creating the EC2 instance, but at the end, it worked out just like that.