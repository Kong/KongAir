#!/bin/bash

# We need this for building the docker images on M1 Macs
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Set Docker Hub username
DOCKER_HUB_USERNAME="kongedu"

# Build and push commands for each Dockerfile
# experience
docker build -t $DOCKER_HUB_USERNAME/kongair-experience:1.0 -f ./experience/Dockerfile ./experience
docker push $DOCKER_HUB_USERNAME/kongair-experience:1.0

# sales/bookings
docker build -t $DOCKER_HUB_USERNAME/kongair-bookings:1.0 -f ./sales/bookings/Dockerfile ./sales/bookings
docker push $DOCKER_HUB_USERNAME/kongair-bookings:1.0

# sales/customer
docker build -t $DOCKER_HUB_USERNAME/kongair-customers:1.0 -f ./sales/customer/Dockerfile ./sales/customer
docker push $DOCKER_HUB_USERNAME/kongair-customers:1.0

# flight-data/flights
docker build -t $DOCKER_HUB_USERNAME/kongair-flights:1.0 -f ./flight-data/flights/Dockerfile ./flight-data/flights
docker push $DOCKER_HUB_USERNAME/kongair-flights:1.0

# flight-data/routes
docker build -t $DOCKER_HUB_USERNAME/kongair-routes:1.0 -f ./flight-data/routes/Dockerfile ./flight-data/routes
docker push $DOCKER_HUB_USERNAME/kongair-routes:1.0