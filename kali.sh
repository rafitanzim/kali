#!/bin/bash

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Installing Docker..."
    sudo apt update && sudo apt install -y docker.io
    sudo systemctl enable --now docker
fi

# Allow Docker to access X server
echo "Enabling X11 forwarding..."
xhost +local:docker

# Pull the latest Kali Linux Docker image
echo "Pulling Kali Linux Docker image..."
docker pull kalilinux/kali-rolling

# Run Kali Linux container with GUI support
echo "Starting Kali Linux with GUI support..."
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --name kali-gui kalilinux/kali-rolling /bin/bash -c "
    apt update &&
    apt install -y kali-desktop-xfce &&
    startxfce4"
