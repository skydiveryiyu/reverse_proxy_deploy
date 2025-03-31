#!/bin/bash

# Exit on error
set -e

echo "Starting reverse proxy deployment..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed"
    echo "To install Docker on Ubuntu 24.04, run:"
    echo "sudo apt update"
    echo "sudo apt install -y docker.io"
    echo "sudo systemctl enable docker"
    echo "sudo systemctl start docker"
    echo "sudo usermod -aG docker \$USER"
    echo "Please log out and back in after adding your user to the docker group"
    exit 1
fi

# Check if Docker Compose plugin is installed
if ! docker compose version &> /dev/null; then
    echo "Error: Docker Compose plugin is not installed"
    echo "To install Docker Compose plugin on Ubuntu 24.04, run:"
    echo "sudo apt update"
    echo "sudo apt install -y docker-compose-plugin"
    exit 1
fi

# Check if required directories exist
if [ ! -d "nginx/conf.d" ]; then
    mkdir -p nginx/conf.d
fi

if [ ! -d "ssl" ]; then
    mkdir -p ssl
fi

# Check if SSL files exist
if [ ! -f "ssl/2025/pem/iciculture.com.pem" ] || [ ! -f "ssl/2025/pem/iciculture.com.key" ]; then
    echo "Error: SSL certificate files not found"
    echo "Please ensure the following files exist:"
    echo "- ssl/2025/pem/iciculture.com.pem"
    echo "- ssl/2025/pem/iciculture.com.key"
    exit 1
fi

# Check if configuration files exist
if [ ! -f "nginx/nginx.conf" ]; then
    echo "Error: nginx.conf file does not exist"
    exit 1
fi

if [ ! -f "nginx/conf.d/default.conf" ]; then
    echo "Error: default.conf file does not exist"
    exit 1
fi

# Stop and remove existing containers
echo "Stopping existing services..."
docker compose down

# Pull latest images
echo "Pulling latest images..."
docker compose pull

# Start services
echo "Starting services..."
docker compose up -d

# Check service status
echo "Checking service status..."
docker compose ps

echo "Deployment completed!"
echo "You can view service logs using:"
echo "docker compose logs -f nginx" 