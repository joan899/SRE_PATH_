How to pull a docker image from the registry and create a container to run 
the program and host it in the 8080 port:

You need to have the docker package installed first. 


- In this case, we're going to work with the nginx docker image, to pull the image we can run this command: 

docker pull nginx

- Then we can insert the image in a container to then be able to execute the program, in this case,
the program will be able in the port 8080, to do this, we can run this command: 

docker run --name my-nginx -d -p 8080:80 --name my-apache-server httpd:latest

   Where the container name is specified: my-nginx. 8080 is the port of the host, where we can access the imagen, and 80 is the container port.
  

- We can also check if the container is running or if this one has a different status: 

docker ps


Now, we can navigate to the port 8080 and see the nginx project running

