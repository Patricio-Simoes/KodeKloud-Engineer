---
date: 25-01-2026
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Cronjobs
---
# README

Task number 15 was focused on scheduling Cronjobs.

The objective was to **create a cronjob named `datacenter`**.

**Requirements:**

- Create a cronjob named `datacenter`;
- Set Its schedule to something like `*/12 * * * *`;
- Name the container `cron-datacenter`;
- Utilize the `nginx` image with `latest tag`;
- Execute the dummy command `echo Welcome to xfusioncorp!`;
- Ensure the restart policy is `OnFailure`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a CronJob is and what it is for;
2. Deploying the CronJob to the cluster;
3. Verify that it is deployed as expected.

### 1. What exactly is a CronJob?

A CronJob is a Kubernetes resource that allows us to schedule and automate the execution of tasks (jobs) at specific times or intervals.

It is essentially the Kubernetes equivalent of the traditional Unix cron utility, but designed to run within a Kubernetes cluster.

### 2. Applying the resource limits to the pod & deploying it

To apply the CronJob to the pod, the following YAML specification was created:

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: datacenter
spec:
  schedule: "*/12 * * * *"  # Every 12 minutes
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: cron-datacenter
            image: nginx:latest
            command:
            - /bin/sh
            - -c
            - echo "Welcome to xfusioncorp!"
          restartPolicy: OnFailure
```

Then, deploying this pod was done using:

```bash
kubectl apply -f ./pod.yaml
```

### 3. Verifying that it was deployed as expected

After deploying the CronJob, i ran the following command to check it's status and ensure that as expected:

```bash
k get cronjobs
```

Which printed a successfull result:

```bash
NAME         SCHEDULE       SUSPEND   ACTIVE   LAST SCHEDULE   AGE
datacenter   */12 * * * *   False     0        <none>          6s
```

The CronJob deploys a pod for running the job.

```bash
kubectl get jobs
```

Expected result:

```bash
NAME                  COMPLETIONS   DURATION   AGE
datacenter-29489352   1/1           9s         3m29s
```

To verify if the job was successful:

```bash
k logs datacenter-29489352-mrmw5
```

Which prints:

```bash
Welcome to xfusioncorp!
```