#!/bin/bash

# Exit on error
set -e

echo "Starting reverse proxy deployment..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed"
    exit 1
fi

# Check if required directories exist
if [ ! -d "nginx/conf.d" ]; then
    mkdir -p nginx/conf.d
fi

if [ ! -d "nginx/ssl" ]; then
    mkdir -p nginx/ssl
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
docker-compose down

# Pull latest images
echo "Pulling latest images..."
docker-compose pull

# Start services
echo "Starting services..."
docker-compose up -d

# Check service status
echo "Checking service status..."
docker-compose ps

echo "Deployment completed!"
echo "You can view service logs using:"
echo "docker-compose logs -f nginx" 