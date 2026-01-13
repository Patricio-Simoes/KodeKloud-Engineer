---
date: "2025-12-31"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Namespaces
  - Pods
---
# README

Task number 3 was focused on creating a namespace and deploying a pod in it, in a pre-configured Kubernetes environment.

The objective was to **create a namespace named `dev` and deploy a POD within it.**.

**Requirements:**

- The namespace must be named `dev`;
- The pod must be named `dev-nginx-pod`;
- The pod must use the `nginx` image with the `latest` tag;

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a namespace is and what it is for.
2. Deploy the pod to the namespace.
3. Verify that it is deployed as expected.

### 1. What exactly is a namespace?

A namespace in Kubernetes is a logical partitioning of resources within a cluster. It allows multiple virtual clusters to exist within a single physical cluster, helping to manage resources and isolate applications effectively.

### 2. Deploying the pod to the namespace

Since the requirements for this pod were not very complex, i was able to create it in an imperative way using `kubectl`:

```bash
kubectl run dev-nginx-pod --image nginx:latest -n dev
```

This command will create the  `dev-nginx-pod` in the `dev` namespace, while using the `nginx:latest` image tag.

### 3. Verifying that it was deployed as expected

After deploying the pod, i ran the following command to check it's status and ensure that it was in the correct namespace:

```bash
kubectl get pods -n dev
```

Which printed a successfull result:

```bash
NAME            READY   STATUS    RESTARTS   AGE
dev-nginx-pod   1/1     Running   0          65s
```

To make sure that it was not deployed in the default namespace, i ran the following command:

```bash
kubectl get pods
```

Which printed the expected result:

```bash
No resources found in default namespace.
```

To make sure that the pod was using the correct image, i inspected the pod using:

```bash
kubectl describe pod dev-nginx-pod -n dev | grep "Image:"
```

This confirmed that the image in use was `nginx` with the `lastest` tag:

```bash
Image:          nginx:latest
```