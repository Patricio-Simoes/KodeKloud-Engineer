---
date: "2025-11-19"
tags:
  - KodeKloud
  - Kubernetes
topics:
  - Pods
---
# README

Task number 1 was focused on creating a pod in a pre-configured Kubernetes environment.

The objective was to **create a pod named pod-nginx using the nginx image**.

**Requirements:**

- Create a pod named `pod-nginx` using the nginx image with the latest tag;
- Set the app label to `nginx_app`, and name the container as `nginx-container`.

## Step-by-Step Solution

When approaching this challenge, I broke it down into a sequence of steps:

1. Understand what a pod is and what it is for.
2. Understand how pods are created.
3. Deploy the pod in the cluster.
4. Verify that it is deployed as expected.

### 1. What Exactly is a pod?

A Pod is the smallest deployable unit in Kubernetes. It represents **one or more containers** that:

- Run together on the same node
- Share the same network namespace (IP address, ports)
- Can optionally share storage volumes

### 2. How are pods created?

Pods are created directly with `kubectl`.

Pods can be created using a YAML manifest:

```bash
kubectl apply -f pod.yaml
```

Or imperatively:

```bash
kubectl run pod-name --image=nginx:latest
```

### 3. Deploying the pod to the cluster

I choose to deploy the pod using a YAML manifest.

In order to do so, i created the following YAML:

```YAML
apiVersion: v1
kind: Pod
metadata:
  name: pod-nginx
  labels:
    app: nginx_app
spec:
  containers:
    - name: nginx-container
      image: nginx:latest
```

Then, applied it using:

```bash
kubectl apply -f pod.yaml
```

### 4. Verifying that it was deployed as expected

After applying the manifest, i ran the following command to check the status of the pod:

```bash
kubectl get pods
```

Which printed a successfull result:

```bash
NAME        READY   STATUS    RESTARTS   AGE
pod-nginx   1/1     Running   0          10s
```

To further make sure, i inspected the pod using:

```bash
kubectl describe pods/pod-nginx
```

This confirmed that the pod was created as defined in the manifest:

```bash
Name:             pod-nginx
Namespace:        default
Priority:         0
Service Account:  default
Node:             kodekloud-control-plane/172.17.0.2
Start Time:       Wed, 19 Nov 2025 21:52:59 +0000
Labels:           app=nginx_app
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:  10.244.0.5
Containers:
  nginx-container:
    Container ID:   containerd://251917988d18c240524e94ed8080cdcd24547f419f23b6517c7b965a40804f48
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:553f64aecdc31b5bf944521731cd70e35da4faed96b2b7548a3d8e2598c52a42
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 19 Nov 2025 21:53:05 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ghwgx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-ghwgx:
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
  Normal  Scheduled  31s   default-scheduler  Successfully assigned default/pod-nginx to kodekloud-control-plane
  Normal  Pulling    31s   kubelet            Pulling image "nginx:latest"
  Normal  Pulled     26s   kubelet            Successfully pulled image "nginx:latest" in 5.197178473s (5.197193134s including waiting)
  Normal  Created    25s   kubelet            Created container nginx-container
  Normal  Started    25s   kubelet            Started container nginx-container
```