TIL:
	- Virtualization vs container approach comparisson 
        - Docker isolated container system. Overview. Architecture. Basic commands
        - Docker file, docker image compilation example

Homework: build a docker image for running python application and to listen port 8080. Image should be as small as reasonably practicable
This time I used simple hello-world-flask-app from one of the previous lessons. I set it to run on port 8080.
In dockerfile the port is redirected to the host 8080. Image size is 53.7Mb, inherits python:3.8-alpine image 
