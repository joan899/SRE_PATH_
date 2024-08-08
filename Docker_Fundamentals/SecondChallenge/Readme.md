Second Docker Challenge: 

We're going to launch a web site, this web site is a manga reader. We'll have the backend and frontend separated by two containers. 
We'll also have a volume and a network for a successful communication through the two containers. We are going to create the volume first,
to have persistence data even when the container must be removed. Then we'll have the network created and finally the two containers. 

Steps: 
1- Creating the volume: 
	docker volume create teemii_data
2- Checking if the volume creation was successful, you should be able to see the volume with this command:
	docker volume ls
3- Creating the network: 
	docker network create teemii_network -d bridge
4- Checking if the network was created successfully: 
	docker network ls
5- Now, we can create the frontend container 
	docker run -d -p 8080:80 --name teemii-frontend dokkaner/teemii-frontend:develop
6- Creating the backend container: 
	docker run -d -p 8080:80 --name teemii-backend dokkaner/teemii-backend:develop
7- Creating the backend container and assinging it the volume and connecting it to the network all in one command: 
	docker run --name teemii-backend -d -p 3000:3000 -v teemii_data:/data --network teemii_network dokkaner/teemii-backend:develop	
8- Connecting the frontend container to the network: 
	docker network connect teemii_network teemii-frontend
9- Now that we have both container connected by the network, we can check if the connection was successful:
	 docker exec -it teemii-frontend ping teemii-backend
10- We can do some testing to verify if the volume was created and assigned correctly: 
	- We can remove the backend container by executing this command: 
		docker rm 5b52d8cc11f5 --force
	- Then, we can create the container again, assigning it the teemii_data volume and connecting it to the network
		docker run --name teemii-backend -d -p 3000:3000 -v teemii_data:/data --network teemii_network dokkaner/teemii-backend:develop
	- Finally, we can navigate to the browser and see if the data is still there	

