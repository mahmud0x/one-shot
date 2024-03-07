#!/bin/bash

# Stop all running containers
docker stop $(docker ps -a -q)

# Remove all containers
docker rm $(docker ps -a -q)

# Remove all Docker images
docker rmi $(docker images -a -q)
