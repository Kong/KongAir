# Set Docker Hub username
DOCKER_HUB_USERNAME="kongedu"
TAG="1.0"

docker buildx create --use

# Build and push commands for each Dockerfile

# experience
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-experience:$TAG -f ./experience/Dockerfile ./experience --push

# sales/bookings
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-bookings:$TAG -f ./sales/bookings/Dockerfile ./sales/bookings --push

# sales/customer
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-customers:$TAG -f ./sales/customer/Dockerfile ./sales/customer --push

# flight-data/flights
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-flights:$TAG -f ./flight-data/flights/Dockerfile ./flight-data/flights --push

# flight-data/routes
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-routes:$TAG -f ./flight-data/routes/Dockerfile ./flight-data/routes --push

