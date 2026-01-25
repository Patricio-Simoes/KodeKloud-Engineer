---
date: "2025-01-24"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Deployments
---
# README

Task number 6 was focused on rolling back a deployment from a previous rollout.

The objective was to **initiate a rollback to the previous revision of the `nginx-deployment`deployment.**.

**Requirements:**

- There exists a deployment named `nginx-deployment`; initiate a rollback to the previous revision.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a deployment rollback is, what it is for and how it is triggered;
2. Trigger the rollback;
3. Verify that it is deployed as expected.

### 1. Understand what a deployment rollback is, what it is for and how it is triggered.

A deployment rollback is the process of reverting a deployment version to a stable one after the new deployment introduces errors, bugs, or unexpected behavior.

### 2. Triggering the rollback

For this scenario, the rollback was performed with the following `kubectl` command:

```bash
kubectl rollout undo deployment/nginx-deployment
```

### 3. Verifying that it was deployed as expected

Verifying that the deployment was successfully rolled back was done using:

```bash
kubectl rollout status deployment/nginx-deployment
```

Which resulted in:

```bash
deployment "nginx-deployment" successfully rolled out
```