---
date: "2025-01-13"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Pods
  - Resource Limits
---
# README

Task number 4 was focused on setting resource limits so that a container running inside a pod does not exceed them.

The objective was to **create a pod named `httpd-pod` and apply resource limits to it.**.

**Requirements:**

- Create a pod named `httpd-pod` with a container named `httpd-container`;
- Use the `httpd` image with the `latest` tag (specify as httpd:latest); 
- Set the following resource limits:
  - Requests: Memory: `15Mi`, CPU: `100m`;
  - Limits: Memory: `20Mi`, CPU: `100m`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a resource limit is and what it is for.
2. Applying the resource limits to the pod & deploying it.
3. Verify that it is deployed as expected.

### 1. What exactly is a resource limit?

A resource limit in Kubernetes define the maximum amount of CPU and memory that a container can consume. 

These limits can be set either at the namespace level, by deploying a resource limit object, or at the pod level, by specifying them in the pod's YAML specification.

For this level, resource limits were applied at the pod level.

### 2. Applying the resource limits to the pod & deploying it

To apply the resource limits to the pod, the following YAML specification was created:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
spec:
  containers:
  - name: httpd-container
    image: httpd:latest
    resources:
      requests:
        memory: "15Mi"
        cpu: "100m"
      limits:
        memory: "20Mi"
        cpu: "100m"
```

Then, deploying this pod was done using:

```bash
kubectl apply -f ./pod.yaml
```

### 3. Verifying that it was deployed as expected

After deploying the pod, i ran the following command to check it's status and ensure that it had the resource limits applied to it:

```bash
kubectl get pod httpd-pod -o yaml | grep -A 6
```

Which printed a successfull result:

```bash
resources:
    resources:
      limits:
        cpu: 100m
        memory: 20Mi
      requests:
        cpu: 100m
        memory: 15Mi
```