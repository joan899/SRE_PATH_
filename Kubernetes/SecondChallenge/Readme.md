Kubernetes deployment:

We're going to create a NGINX deployment, then update it with a rolling update while registering the update history. 

1. Creating the namespace that we're going to work with:
	kubectl create ns cloudstation

2. Creating the deployment.yaml, we're going to use this file to create the deployment with all the necessary configuration:
	kubectl create deployment nginx-deployment -n cloudstation --image=nginx:1.26.2 --replicas=3 --dry-run=client -oyaml > deployment.yaml

3. Applying the yaml file in order to create the deployment with its three replicas:
	kubectl apply -f deployment.yaml

4. Checking if the pods were created successfully:
	kubectl get pods -n cloudstation

5. Updating the nginx version of the images by a rollout: 
	kubectl set image deployment/nginx-deployment nginx=nginx:1.27.1 -n cloudstation --record

6. We can check if the update was successfully and also watch the status of the pods:
	kubectl rollout status deployment/nginx-deployment --namespace=cloudstation
	kubectl get pods --watch -n cloudstation

7. Review the deployment history:
	kubectl rollout history deployment/nginx-deployment -n cloudstation

8. Describe the deployment:
	kubectl describe deployment nginx-deployment -n cloudstation





