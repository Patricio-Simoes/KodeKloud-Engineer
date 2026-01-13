---
date: "2025-11-24"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Deployments
  - Pods
---
# README

Task number 2 was focused on creating a deployment in a pre-configured Kubernetes environment.

The objective was to **create a deployment named nginx to deploy the nginx application**.

**Requirements:**

- Create a deployment named `nginx`;
- The deployment should deploy the `nginx` application.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a deployment is and what it is for.
2. Understand how deployments are created.
3. Deploy the deployment in the cluster.
4. Verify that it is deployed as expected.

### 1. What Exactly is a deployment?

A Deployment in Kubernetes is a higher-level controller that manages replica sets and pods for you. It provides a declarative way to define what you want your application to look like, and Kubernetes ensures that the cluster always matches that desired state.

### 2. How are deployments created?

Deployments are created directly with `kubectl`.

Deployments can be created using a YAML manifest:

```bash
kubectl apply -f deployment.yaml
```

### 3. Deploying the deployment to the cluster

In order to deploy, i created the following YAML:

```YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx_app
  template:
    metadata:
      labels:
        app: nginx_app
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
```

Then, applied it using:

```bash
kubectl apply -f deployment.yaml
```

### 4. Verifying that it was deployed as expected

After applying the manifest, i ran the following command to check the status of the pod (created through the deployment):

```bash
kubectl get pods
```

Which printed a successfull result:

```bash
NAME                     READY   STATUS    RESTARTS   AGE
nginx-56466f869b-f5sgg   1/1     Running   0          3s
```

To further make sure, i inspected the pod using:

```bash
kubectl describe pods/nginx-56466f869b-f5sgg
```

This confirmed that the pod was created as defined in the manifest:

```bash
Name:             nginx-56466f869b-f5sgg
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Mon, 24 Nov 2025 14:38:47 +0000
Labels:           app=nginx_app
                  pod-template-hash=56466f869b
Annotations:      <none>
Status:           Running
IP:               10.244.0.6
IPs:
  IP:           10.244.0.6
Controlled By:  ReplicaSet/nginx-56466f869b
Containers:
  nginx:
    Container ID:   containerd://4d1ddeb64a0ae5f02e5ecc7e0acae32ec987d8d085d6990c492829bdb83b4a37
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:553f64aecdc31b5bf944521731cd70e35da4faed96b2b7548a3d8e2598c52a42
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 24 Nov 2025 14:38:48 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ggzsw (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-ggzsw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  29s   default-scheduler  Successfully assigned default/nginx-56466f869b-f5sgg to kodekloud-control-plane
  Normal  Pulling    29s   kubelet            Pulling image "nginx:latest"
  Normal  Pulled     28s   kubelet            Successfully pulled image "nginx:latest" in 148.39384ms (148.409099ms including waiting)
  Normal  Created    28s   kubelet            Created container nginx
  Normal  Started    28s   kubelet            Started container nginx
```