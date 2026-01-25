---
date: "2025-01-25"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - ReplicaSets
---
# README

Task number 7 was focused on creating a ReplicaSet in Kubernetes.

The objective was to **create a ReplicaSet using `httpd` image.**.

**Requirements:**

- Create a ReplicaSet using `httpd` image with latest tag and name it `httpd-replicaset`;
- Apply labels: `app` as `httpd_app`, `type` as `front-end`;
- Name the container `httpd-container`. Ensure the replica count is `4`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a ReplicaSet is and what it is for;
2. Understand how ReplicaSet are created;
3. Deploy the ReplicaSet in the cluster;
4. Verify that it is deployed as expected.

### 1. Understand what a ReplicaSet is, what it is for and how it is triggered.

A ReplicaSet is a Kubernetes resource that ensures a specified number of pod replicas are running at any given time.

It is primarily used to maintain the availability and scalability of an application by managing the lifecycle of pods.

### 2. How are ReplicaSets created?

A ReplicaSet is triggered and managed through its YAML or JSON manifest file, which defines the desired state of the pods:

```bash
kubectl apply -f pod.yaml
```

### 3. Deploying the ReplicaSet to the cluster

The following YAML was created for this scenario:

```YAML
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: httpd-replicaset
  labels:
    app: httpd_app
    type: front-end
spec:
  template:
    metadata:
      name: httpd-pod
      labels:
        app: httpd_app
        type: front-end
    spec:
      containers:
        - name: httpd-container
          image: httpd:latest
  replicas: 4
  selector:
    matchLabels:
      app: httpd_app
      type: front-end
```

Then, applied using:

```bash
kubectl apply -f rs.yaml
```

### 3. Verifying that it was deployed as expected

After applying the manifest, the following command was used to check the status of the ReplicaSet:

```bash
kubectl get rs
```

Returning a successful output:

```bash
NAME               DESIRED   CURRENT   READY   AGE
httpd-replicaset   4         4         0       5s
```

To check if the pods were created successfuly:

```bash
kubectl get pods
```

Returning a successful output:

```bash
kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
httpd-replicaset-2xtkj   1/1     Running   0          110s
httpd-replicaset-b8wsq   1/1     Running   0          110s
httpd-replicaset-ld2sc   1/1     Running   0          110s
httpd-replicaset-s8r2z   1/1     Running   0          110s
```

Finally, (despite the pods being named after `httpd-replicaset`), verifying the pod ownership requires:

```bash
kubectl get pod httpd-replicaset-2xtkj -o jsonpath='{.metadata.ownerReferences[0].name}'
```

Returning a successful output:

```bash
httpd-replicaset
```