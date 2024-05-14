# Set Docker Hub username
DOCKER_HUB_USERNAME="kongedu"

# Ensure buildx is enabled
docker buildx create --use

# Build commands for each Dockerfile
# experience
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-experience:1.0 -f ./experience/Dockerfile ./experience --load

# sales/bookings
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-bookings:1.0 -f ./sales/bookings/Dockerfile ./sales/bookings --load

# sales/customer
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-customers:1.0 -f ./sales/customer/Dockerfile ./sales/customer --load

# flight-data/flights
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-flights:1.0 -f ./flight-data/flights/Dockerfile ./flight-data/flights --load

# flight-data/routes
docker buildx build --platform linux/amd64,linux/arm64 -t $DOCKER_HUB_USERNAME/kongair-routes:1.0 -f ./flight-data/routes/Dockerfile ./flight-data/routes --load
