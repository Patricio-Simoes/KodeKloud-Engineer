---
date: "2025-01-13"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Deployments
---
# README

Task number 5 was focused on triggering a rolling update from an existing deployment.

The objective was to **trigger a rolling update for the existing `nginx-deployment`, updating the `nginx:1.16` image to `nginx:1.17`**.

**Requirements:**

- In the existing deployment named `nginx-deployment`, execute a rolling update for the running application, integrating the `nginx:1.17` image. 

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a rolling update is, what it is for and how it is triggered.
2. Identify existing image & perform the update
3. Verify that it is deployed as expected.

### 1. Understand what a rolling update is, what it is for and how it is triggered.

A rolling update is a deployment strategy in Kubernetes that allows you to update applications with zero downtime. 

It replaces the old versions of existing applications with the new ones incrementally, ensuring that some instances of the application are always available to serve traffic.

**Note:** Kubernetes offers two types of updates, rolling and recreate. Rolling is the default update type.

### 2. Identify existing image & perform the update

Given the existing deployment, the following command can be used for retrieving the used image on the defined containers:

```bash
kubectl describe deploy/nginx-deployment | grep -A 3 Containers:
```

Verifying that the deployment is defining the `nginx-app`, which in turn is using the `nginx:1.16` image:

```bash
Containers:
  nginx-container:
  Image:         nginx:1.16
  Port:          <none>
```

Since the Rolling update is the default update type for deployments, the process can be triggered using:

```bash
kubectl set image deployment/nginx-deployment nginx-container=nginx:1.17
```

### 3. Verifying that it was deployed as expected

After running the update, it's status could be checked using:

```bash
kubectl rollout status deploy/nginx-deployment
```

Returning a successful output:

```bash
deployment "nginx-deployment" successfully rolled out
```

Upon inspecting the image, using the same command as before:

```bash
kubectl describe deploy/nginx-deployment | grep -A 3 Containers:  
```

It's possible to verify that the image as been updated:

```bash
Containers:
   nginx-container:
    Image:         nginx:1.17
    Port:          <none>
```

Finally, verifying the status of the new pods requires:

```bash
kubectl get pods
```

Returning:

```bash
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-5dd558cf95-dk6t8   1/1     Running   0          5m9s
nginx-deployment-5dd558cf95-jjrm2   1/1     Running   0          5m6s
nginx-deployment-5dd558cf95-q5f68   1/1     Running   0          5m16s
```