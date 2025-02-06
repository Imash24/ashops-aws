#!/bin/bash

set -ex  # Exit on error (-e) and print commands (-x)

# Update package lists
sudo apt update

# Install required dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists again
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
docker --version

# Start and enable Docker
sudo systemctl enable --now docker

# Add user to Docker group (avoids using sudo for Docker commands)
sudo usermod -aG docker $USER
newgrp docker

# Pull the latest version of your Docker image
docker pull heisash24/ashflask:latest

# Run the container with restart policy
docker run -d -p 5000:5000 --name ashflask --restart unless-stopped heisash24/ashflask
