Challenge: creating a namespace with two containers in one pod.

1. Installing Kind
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin
2. Installing Kubectl: 
	Follow this guide: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

3. Creating a Kubernetes cluster:
	- nano kind-config.yaml
	- Paste this:
		kind: Cluster
		apiVersion: kind.x-k8s.io/v1alpha4
		nodes:
  			- role: control-plane
    		          image: kindest/node:v1.31.0
  			- role: worker
    			  image: kindest/node:v1.31.0
  			- role: worker
    			  image: kindest/node:v1.31.0
	- kind create cluster
		kind create cluster -n challenge1 --config kind-config.yaml
	- make sure you're in the right context:
		kubectl config current-context						

4. Creating a namespace called pokeland
	kubectl create ns pokeland
5. Creating a pod with two containers by a yaml file:
	- nano pikachu-pod.yaml
	- paste this:
		apiVersion: v1
		kind: Pod
		metadata:
  			creationTimestamp: null
 		    name: pikachu-pod
  			namespace: pokeland
		spec:
  			containers:
  			- image: nginx
   			  name: nginx-container
    			  resources: {}
  			- image: redis
    			  name: redis-container
    			  resources: {}
  			dnsPolicy: ClusterFirst
  			restartPolicy: Always
		status: {}
	- executing the file to create the pod with its two containers:
		kubectl apply -f pikachu-pod.yaml
6. We can check if the pod and its containers were successfully created:
	kubectl get pod -n pokeland
7. Verify that the two containers are working:
	kubectl logs pikachu-pod -c nginx-container -n pokeland
	kubectl logs pikachu-pod -c redis-container -n pokeland




