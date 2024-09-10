Challenge: 
Apply a taint to a node to prevent regular pods from being scheduled there, then create a pod with a tolerance for that taint so it can be scheduled on the tainted node.

Steps:

1. Applying a taint that will prevent pods without tolerancy being scheduled in the node: 
```kubectl taint nodes challenge1-worker2 cloud-station=true:NoSchedule```

2. Creating a yalm file that will create a pod and asign it the toleration in order to able to schedule it to the node:
```nano TolerantCloudStation-Pod.yaml```

3. Copy and paste this in the yaml file:
```apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: tolerant-cloud-station-pod
  namespace: pokeland
spec:
  containers:
    - image: nginx
      name: nginx-container
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
    - key: cloud-station
      operator: Equal
      value: "true"
      effect: NoSchedule
```

4. Creating the pod by applying the yaml file: 
```kubectl apply -f tolerant-cloud-station-pod.yaml```

5. Now the new pod can be checked to verify if it was able to be scheduled in the node by running this command: 
```kubectl get pods```

6. Another pod can be also created to ensure that the taint was added correctly to the node:
```nano no-tolerant-cloud-station-pod-test.yaml```

7. Copy and paste this (this new file does not have the tolerancy to be able to be scheduled in the node):
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: no-tolerant-cloud-station-pod-test
  namespace: pokeland
spec:
  containers:
    - image: nginx
      name: nginx-container
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```

8. Create the pod by applying the yaml file:
```kubectl apply -f no-tolerant-cloud-station-pod-test.yaml```

9. The pod can be also checked in which node was scheduled:
```kubectl get pods```

