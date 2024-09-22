# Communication between Pods in Different Namespaces in Kubernetes

Goal: Two namespaces must be created, each with a deployment of 3 replicas. Each deployment should be exposed via a ClusterIP Service. Finally, it will demonstrate how to enable a Pod from Namespace X to communicate with a Pod from Namespace Y, explaining the commands used.

### Creating the required two namespaces
```kubectl create namespace namespace-1```
```kubectl create namespace namespace-2```

Verify if the namespaces were created successfully: 
```kubectl get namespaces```

### Create a deployments with 3 replicas in each namespace

First deployment in the namespace 'namespace-1':

Creating the yaml file, copy and paste the code below

```nano deployment1.yaml```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-first
  name: nginx-first
  namespace: namespace-1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-first
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-first
    spec:
      containers:
      - image: nginx:1.26.2
        imagePullPolicy: Always
        name: nginx-first
        ports:
        - containerPort: 80
        resources: {}
status: {}
```
Applying the yaml file in order to create the deployment

```kubectl apply -f deployment1.yaml```

Check if the deployment and its pods were created 
```kubectl get pods -n namespace-1```


Creating the second deployment, copy and paste the code below
```nano deployment2.yaml```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-second
  name: nginx-second
  namespace: namespace-2
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx-second
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-second
    spec:
      containers:
      - image: nginx:1.26.2
        imagePullPolicy: Always
        name: nginx-second
        ports:
        - containerPort: 80
        resources: {}
status: {}
```

```kubectl apply -f deployment2.yaml```

```kubectl get pods -n namespace-2```


### Expose each deployment with a ClusterIP Service.

Run this command
```kubectl expose deployment nginx-deployment-first -n namespace-1 --port=80 --target-port=80 --type=ClusterIP --dry-run=client -oyaml```

Create a yaml file and copy and paste the result of the previous command in this yaml file:
```nano nginx-deployment-first-svc.yaml```

The yaml file must look like this:
```                                         
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  name: nginx-first-svc
  namespace: namespace-1
  labels:
    app: nginx-first
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx-first
  type: ClusterIP
```

Check if the service was created:
```kubectl get svc -n namespace-1```

Now, expose the second deployment by creating another service, create a yaml file: 
```kubectl expose deployment nginx-deployment-second -n namespace-2 --port=80 --target-port=80 --type=ClusterIP --dry-run=client -oyaml```

Create the second yaml file:
```nano nginx-deployment-second-svc.yaml```

The second yaml file must look like this:                                                    
```
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  name: nginx-second-svc
  namespace: namespace-2
  labels:
    app: nginx-second
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx-second
  type: ClusterIP
```

Apply the yaml file in order to create the second service:
```kubectl apply -f nginx-deployment-second-svc.yaml```

Check if the service was created:
```kubectl get svc -n namespace-2```

### Communication Challenge

It is time to test the communication between pods in the two different namespaces
- In order to test the communication, execute this command to open a pod in the namespace-1 and communicate with a pod in the namespace-2 by the service

```kubectl exec -it nginx-first-574d74f669-hk26z -n namespace-1 -- /bin/bash```

- In the new shell, execute this command that will allow the communication, it is going to access to a pod in the namespace-2 by the 'nginx-second-svc' service.

```curl http://nginx-second-svc.namespace-2```

And the test can be done viceversa as well, from the 'namespace-2' to the 'namespace-1':
```kubectl exec -it nginx-second-132d74f669-ia12z -n namespace-2 -- /bin/bash```

- run this command in the new shell:
```curl http://nginx-first-svc.namespace-1```

### Demonstrate the communication.

As a result of the above commands, the communication between the pods produces the following output, which reflects the results from the image's pods in the deployment:

```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```


