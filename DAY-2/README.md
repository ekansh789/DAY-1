Docker Compose Setup and Validation
Launched the application using the Docker Compose file.
Verified application accessibility after deployment.
Used the following commands for deployment and cleanup:
docker compose up -d
docker compose down
Updated the docker-compose.yaml file by modifying the UI color configuration.
Recreated only the required service using:
docker compose up -d --force-recreate ui
Verified running services using:
docker compose ps
Verified application health checks from the UI and topology page.
Multi-Platform Docker Image Build Using Docker Buildx and QEMU
Objective

Implemented a solution to build Docker images for both amd64 and arm64 architectures in a single build process using Docker Buildx with QEMU emulation.

QEMU Emulator Installation

Installed the QEMU simulator to support multi-architecture builds:

docker run --privileged --rm tonistiigi/binfmt --install all
Docker Buildx Multi-Platform Build

Navigated to the UI application directory and executed the following command to build and push multi-platform Docker images:

DOCKER_BUILDKIT=1 docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "${IMAGE}" \
  --push .
Activities Performed
Created and tested Docker Buildx builder.
Configured QEMU emulation support.
Built Docker images for:
linux/amd64
linux/arm64
Tagged and pushed the image to Docker Hub after docker login.
Docker Container Validation

Tested the generated image by running the container:

docker run --name ekansh-multi-amd64 -p 8889:8080 -d ${IMAGE}

Verified:

Container startup
Application accessibility
Multi-platform image functionality