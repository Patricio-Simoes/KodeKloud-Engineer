---
date: 25-01-2026
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Jobs
---
# README

Task number 9 was focused on creating a cluster job.

The objective was to **Create a job named `countdown-nautilus` that runs the command `sleep 5`**.

**Requirements:**

- Create a job named `countdown-nautilus`;
- The spec template should be named `countdown-nautilus`, and the container should be named `container-countdown-nautilus`;
- Utilize image `ubuntu` with `latest` tag and set the restart policy to `Never`;
- Execute the command `sleep 5`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a Job is and what it is for;
2. Deploying the Job to the cluster;
3. Verify that it is deployed as expected.

### 1. What exactly is a Job?

A Job in Kubernetes is a resource that allows us to run one or more Pods to perform a specific task and ensure that a specified number of Pods complete successfully.

Unlike long-running applications managed by Deployments or ReplicaSets, Jobs are designed for short-lived, batch-oriented tasks that terminate once the task is completed.

### 2. Applying the resource limits to the pod & deploying it

To apply the Job to the cluster, the following YAML specification was created:

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: countdown-nautilus
spec:
  template:
    metadata:
      name: countdown-nautilus
    spec:
      containers:
      - name: container-countdown-nautilus
        image: ubuntu:latest
        command:
         - "bin/bash"
         - "-c"
         - "sleep 5"
      restartPolicy: Never
```

Then, deploying this Job was done using:

```bash
kubectl apply -f ./job.yaml
```

### 3. Verifying that it was deployed as expected

After deploying the Job, i ran the following command to check it's status and ensure that as expected:

```bash
kubectl get jobs
```

Which printed a successful result:

```bash
NAME                 COMPLETIONS   DURATION   AGE
countdown-nautilus   1/1           11s        18s
```

Since the command `sleep 5` produces no output, we will assume that the job was successful based on the `1/1 COMPLETIONS`.